class User < ApplicationRecord
  has_secure_password

  enum role: [:regular, :admin]

  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }

  # Additional methods for handling authentication, roles, or other user-related logic can be added here.
end
