class User < ApplicationRecord
  has_secure_password
  has_many :meal_plans

  validates :email, presence: true, uniqueness: { case_sensitive: false }, email: true
  validates :password, presence: true, length: { minimum: 6 }
  
  enum role: { regular: 0, admin: 1 }

  def get_meal_plans
    self.meal_plans
  end

  def make_admin!
    update(role: :admin)
  rescue ActiveRecord::RecordInvalid => e
    log_error('make_admin failed!')
  end
end
