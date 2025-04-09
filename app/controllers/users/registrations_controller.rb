# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
 respond_to :json
end
# This controller inherits from Devise's RegistrationsController and is set up to respond to JSON requests.
# It allows for custom behavior when users register, such as sending a confirmation email or handling errors.