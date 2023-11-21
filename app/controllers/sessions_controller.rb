class SessionsController < ApplicationController
  skip_before_action :authenticate_request, only: :create
  
  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      token = JwtService.encode(user_id: user.id)
      render json: { token: token, redirect_url: '/' }, status: :ok
    else
      log_error('Invalid email or password')
      render_error('Invalid email or password', :unauthorized)
    end
  end

  def destroy
    head :no_content
  end 
  
  private

  def render_error(message, status)
    render json: { error: message }, status: status
  end

  def log_error(message)
    Rails.logger.error("ERROR: #{message}")
  end
end
