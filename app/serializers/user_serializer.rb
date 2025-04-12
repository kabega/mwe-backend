class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :email, :username, :created_at
  attribute :created_at do |user|
    user.created_at&.strftime('%d-%m-%Y')
  end
end
