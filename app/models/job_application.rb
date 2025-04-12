class JobApplication < ApplicationRecord
  belongs_to :user
  belongs_to :job_listing
  enum status: {
    applied: 'applied',
    reviewed: 'reviewed'
  }, default: 'applied'
end
