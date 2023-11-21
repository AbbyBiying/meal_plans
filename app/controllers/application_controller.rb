class ApplicationController < ActionController::API
  before_action :authenticate_request
  attr_reader :current_user

  private

  def authenticate_request
    @current_user = authorize_request
    render json: { error: 'Not authorized' }, status: :unauthorized unless @current_user
  end

  def authorize_request
    user_id = JwtService.decode(http_auth_header)['user_id']
    return User.find_by(id: user_id)
  end

  def http_auth_header
    if request.headers['Authorization'].present?
      return request.headers['Authorization'].split(' ').last
    end

    nil
  end
end