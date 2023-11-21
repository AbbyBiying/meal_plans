# app/models/user.rb
class User < ApplicationRecord
  has_secure_password

  # Validations
  validates :email, presence: true, uniqueness: true, email: true
  validates :password, presence: true, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }

  # Callbacks
  before_save :transform_email

  def decoded_email
    URI.decode_www_form_component(email)
  end
  
  private

  def transform_email
    # Downcase and encode the email before saving
    self.email = URI.encode_www_form_component(email.downcase)
  end
end
