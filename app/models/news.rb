class News < ApplicationRecord
  belongs_to :user

  # Active Storage attachment for images
  has_one_attached :photo

  # Custom validation for image types
  validate :acceptable_image

  private

  def acceptable_image
    return unless photo.attached?

    errors.add(:photo, 'must be an image') unless photo.blob.content_type.start_with?('image/')

    return unless photo.blob.byte_size > 5.megabytes

    errors.add(:photo, 'must be less than 5MB')
  end
end
