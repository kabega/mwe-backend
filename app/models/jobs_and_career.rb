class JobsAndCareer < ApplicationRecord
  # Validations
  validates :job_title, presence: true
  validates :department, presence: true
  validates :job_description, presence: true
  validates :job_type, presence: true, inclusion: { in: %w[Permanent Contract Part-time Internship Temporary] }
  validates :level, presence: true, inclusion: { in: ['Entry Level', 'Mid Level', 'Senior', 'Executive', 'Manager'] }
  validates :status, presence: true, inclusion: { in: %w[Draft Published Closed Filled] }
  validates :contact_email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true
  validate :deadline_cannot_be_in_the_past, if: :application_deadline_changed?

  # Scopes for filtering
  scope :published, -> { where(status: 'Published') }
  scope :active, -> { published.where('application_deadline >= ?', Date.today) }
  scope :by_department, ->(department) { where(department: department) }

  # Helper methods to convert text to arrays
  def requirements_list
    requirements.present? ? requirements.split("\n").reject(&:blank?) : []
  end

  def responsibilities_list
    responsibilities.present? ? responsibilities.split("\n").reject(&:blank?) : []
  end

  private

  def deadline_cannot_be_in_the_past
    return if application_deadline.blank?

    return unless application_deadline < Date.today

    errors.add(:application_deadline, 'cannot be in the past')
  end
end
