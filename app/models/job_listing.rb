class JobListing < ApplicationRecord
  belongs_to :user
  has_many :job_applications, dependent: :destroy
  validates :title, :description, :status, :location, :salary, :salary_currency, :deadline, :qualifications,
            :experience, :job_type, presence: true
  validate :deadline_must_be_in_future
  
  private

  def deadline_must_be_in_future
    return if deadline.blank?

    return unless deadline <= Date.current

    errors.add(:deadline, 'must be in the future')
  end
end
