FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password123' } # Change this to a more secure default password if needed
    password_confirmation { 'password123' }
    role { 0 } # Adjust the role as needed, 0 might represent a default role

    trait :admin do
      role { 1 } # Assuming 1 represents an admin role
    end
  end
end
