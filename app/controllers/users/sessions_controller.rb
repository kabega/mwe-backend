class Users::SessionsController < Devise::SessionsController
  include RackSessionsFix
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    if resource.present? && resource.id.present?
      render json: {
        status: {
          code: 200,
          message: 'Logged in successfully'
        },
        data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
      }, status: :ok
    else
      render json: {
        status: {
          code: 401,
          message: 'Invalid email or password'
        }
      }, status: :unauthorized
    end
  end

  def respond_to_on_destroy
    if current_user
      render json: {
        status: 200,
        message: 'Logged out successfully'
      }, status: :ok
    else
      render json: {
        status: 401,
        message: "Couldn't find an active session."
      }, status: :unauthorized
    end
  end
end
