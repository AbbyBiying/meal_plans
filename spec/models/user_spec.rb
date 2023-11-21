# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    subject { build(:user) } # Use build instead of create for validations

    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_length_of(:password).is_at_least(6) }
    it { is_expected.to validate_confirmation_of(:password) }

    it 'requires an email' do
      user = build(:user, password: nil)
      expect(user).not_to be_valid
    end

    it 'requires a minimum password length' do
      user = build(:user, password: '12345')
      expect(user).not_to be_valid
    end

    it 'allows a password of minimum length' do
      user = build(:user, password: '123456', password_confirmation: '123456')
      expect(user).to be_valid
    end

    it 'requires a maximum password length' do
      user = build(:user, password: 'a' * 72)
      expect(user).not_to be_valid
    end
    
    it 'requires a unique email' do
      existing_user = create(:user, email: 'user@example.com', password: '12345abc', password_confirmation: '12345abc')

      if User.exists?(existing_user.id)
        puts "existing_user with ID #{existing_user.id} successfully saved to the database."
      else
        puts "Failed to save existing_user to the database."
      end

      new_user = build(:user, email: 'user@example.com', password: '12345absfasdfc', password_confirmation: '12345absfasdfc')

      expect(new_user).not_to be_valid
      expect(new_user.errors[:email]).to include('has already been taken')
    end
  end


  describe 'has_secure_password' do
    it 'is expected to have secure password' do
      user = build(:user, password: 'password', password_confirmation: 'password')
      expect(user).to have_secure_password
    end
  end
end
