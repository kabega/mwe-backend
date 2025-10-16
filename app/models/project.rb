class Project < ApplicationRecord
  # Active Storage for multiple document uploads
  has_many_attached :documents

  # Validations
  validates :title, presence: true
  validates :department, presence: true
  validates :description, presence: true
  validates :objective, presence: true
  validates :status, presence: true, inclusion: { in: %w[Planning Active On-Hold Completed Cancelled] }
  validates :priority, presence: true, inclusion: { in: %w[Low Medium High Critical] }
  validates :budget, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validate :end_date_after_start_date

  private

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    return unless end_date < start_date

    errors.add(:end_date, 'must be after the start date')
  end
end
