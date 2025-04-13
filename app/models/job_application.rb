class JobApplication < ApplicationRecord
  after_save :applicationcounter
  belongs_to :user
  belongs_to :job_listing
  validates :resume, presence: true
  validates :cover_letter, presence: true
  validates :status, inclusion: {
    in: %w[Submitted Under Review Accepted Rejected],
    message: "%<value>s is not a valid status. Use 'Submitted', 'Under Review', 'Accepted', or 'Rejected'"
  }
  def applicationcounter
    job_listing.increment!(:application_counter)
  end
end
