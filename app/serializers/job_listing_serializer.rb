class JobListingSerializer
  include JSONAPI::Serializer
  attributes :id, :title, :description, :location, :status,
             :qualifications, :experience, :salary, :salary_currency,
             :deadline, :job_type, :application_counter

  belongs_to :user
end
