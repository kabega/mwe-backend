class JobApplicationSerializer
  include JSONAPI::Serializer
  attributes :id, :status, :resume, :cover_letter
end
