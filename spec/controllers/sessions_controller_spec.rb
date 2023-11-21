require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let(:user) { create(:user, password: 'password123', password_confirmation: 'password123') }

  describe 'POST #create' do
    context 'with valid credentials' do
      it 'returns a valid authentication token and redirect URL' do
        post :create, params: { email: user.email, password: 'password123' }
        expect(response).to have_http_status(:ok)

        body = JSON.parse(response.body)
        expect(body).to have_key('token')
        expect(body).to have_key('redirect_url')
        expect(body['redirect_url']).to eq('/')
      end
    end

    context 'with invalid credentials' do
      it 'returns an unauthorized response' do
        post :create, params: { email: 'invalid@example.com', password: 'invalid_password',password_confirmation: 'password' }

        expect(response).to have_http_status(:unauthorized)

        body = JSON.parse(response.body)
        expect(body).to have_key('error')
        expect(body['error']).to eq('Invalid email or password')
      end
    end
  end

end
