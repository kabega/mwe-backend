class User < ApplicationRecord
  before_validation :generate_random_username, on: :create
  include Devise::JWT::RevocationStrategies::JTIMatcher
  has_many :job_listings, foreign_key: 'user_id'
  has_many :job_applications, foreign_key: 'user_id'
  has_many :user_roles, foreign_key: 'user_id'
  has_many :roles, through: :user_roles
  has_many :user_permissions, foreign_key: 'user_id'
  has_many :permissions, through: :user_permissions

  devise :database_authenticatable, :registerable,
         :validatable, :jwt_authenticatable, jwt_revocation_strategy: self
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :first_name, :last_name, presence: true
  validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }
  private

  def generate_random_username
    return if first_name.blank? || last_name.blank?

    # Get first letters (handles empty/multi-part names)
    first_initial = first_name.first.upcase
    last_initial = last_name.first.upcase

    # Generate random 4-digit number
    random_num = rand(1000..9999)

    # Create base username
    base_username = "#{first_initial}#{last_initial}#{random_num}"

    # Ensure uniqueness
    self.username = unique_username(base_username)
  end

  def unique_username(base)
    # If username exists, generate new random number
    counter = 1
    new_username = base

    while User.exists?(username: new_username)
      new_username = "#{base[0..1]}#{rand(1000..9999)}"
      counter += 1
      break if counter > 10 # Prevent infinite loops
    end

    new_username
  end
end
