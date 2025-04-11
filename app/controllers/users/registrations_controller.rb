class Users::RegistrationsController < Devise::RegistrationsController
  include RackSessionsFix
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    if resource.persisted?
      render json: {
        status: { code: 200, message: 'Signed up sucessfully.' },
        data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
      }
    else
      render json: {
        status: { code: 422, message: "User couldn't be created. #{resource.errors.full_messages.to_sentence}" }
      }, status: :unprocessable_entity
    end
  end
end
# This controller inherits from Devise's RegistrationsController and is set up to respond to JSON requests.
# It allows for custom behavior when users register, such as sending a confirmation email or handling errors.
