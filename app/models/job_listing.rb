class JobListing < ApplicationRecord
  belongs_to :user
  has_many :job_applications, dependent: :destroy
  validates :title, :description, :status, :location, :salary, :salary_currency, :deadline, :qualifications,
            :experience, :job_type, presence: true
  validate :deadline_must_be_in_future
  validates :status, inclusion: {
    in: %w[Open Closed],
    message: "%<value>s is not a valid status. Use 'Open' or 'Closed'"
  }
  validates :salary, numericality: { greater_than: 0 }
  validates :job_type, inclusion: {
    in: %w[Full-Time Part-Time Contract],
    message: "%<value>s is not a valid job type. Use 'Full-Time', 'Part-Time', or 'Contract'"
  }

  private

  def deadline_must_be_in_future
    return if deadline.blank?

    return unless deadline <= Date.current

    errors.add(:deadline, 'must be in the future')
  end
end
