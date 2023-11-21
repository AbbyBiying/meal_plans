class MealPlansController < ApplicationController
  before_action :set_meal_plan, only: %i[show update destroy]
  before_action :authenticate_request

  # GET /meal_plans
  def index
    @meal_plans = current_user.admin? ? MealPlan.all : current_user.meal_plans
    render json: @meal_plans
  end

  # GET /meal_plans/1
  def show
    render json: @meal_plan
  end

  # POST /meal_plans
  def create
    @meal_plan = current_user.meal_plans.build(meal_plan_params)

    if @meal_plan.save
      render json: @meal_plan, status: :created, location: user_meal_plans_path(current_user, @meal_plan)
    else
      render json: { errors: @meal_plan.errors.full_messages }, status: :unprocessable_entity    
    end
  end

  # PATCH/PUT /meal_plans/1
  def update
    if @meal_plan.update(meal_plan_params)
      render json: @meal_plan
    else
      render json: @meal_plan.errors, status: :unprocessable_entity
    end
  end

  # DELETE /meal_plans/1
  def destroy
    @meal_plan.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meal_plan
      @user = User.find(params[:user_id])
      # Check if the current user is an admin or the owner of the meal plan
      if current_user.admin? || current_user == @user
        @meal_plan = @user.meal_plans.find(params[:id])
      else
        render json: { error: 'Not authorized' }, status: :unauthorized
      end
    end

    
    # Only allow a list of trusted parameters through.
    def meal_plan_params
      params.require(:meal_plan).permit(:name, :preferences, :goals, :allergies, :cuisines, :amounts, :user_id)
    end
    
end
