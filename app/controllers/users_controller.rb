class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: :create

  # GET /users
  def index
    token = JwtService.encode(user_id: current_user.id)
    if current_user.admin?
      @users = User.all
      render json: { users: @users, token: token }
    else
      render json: { error: 'Not authorized' }, status: :unauthorized
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      token = JwtService.encode(user_id: @user.id)
      puts token

      render json: { user: @user, token: token }, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(params[:id])
    render json: { user: @user, meal_plans: @user.meal_plans }
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
