class ApplicationController < ActionController::API
  before_action :authenticate_request
  attr_reader :current_user

  private

  def authenticate_request
    @current_user = authorize_request
    unless @current_user
      render json: { error: 'Not authorized', redirect_url: signup_url }, status: :unauthorized
    end
  end   

  def authorize_request
    JwtService.decode(http_auth_header)
  end

  def http_auth_header
    if request.headers['Authorization'].present?
      return request.headers['Authorization'].split(' ').last
    end

    nil
  end
end
