# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
umbrella = Umbrella.find_or_create_by!(name: "Main Umbrella") do |u|
  u.description = "Default umbrella created on startup"
end

User.find_or_create_by!(email: "admin@example.com") do |user|
  user.username = "admin"
  user.first_name = "System"
  user.last_name  = "Admin"
  user.phone      = "+256700000000"
  user.bio        = "Super admin user"
  user.password   = "supersecret"  # change in production
  user.umbrella   = umbrella
  user.jti        = SecureRandom.uuid
end
