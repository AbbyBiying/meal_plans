require_relative '../services/chat_gpt_service'
class GetResponseJob < ApplicationJob
  queue_as :default
  def perform(meal_plan_id)
    meal_plan = MealPlan.find(meal_plan_id)

    chatgpt_service = ChatGPTService.new
    user_input = "user name is #{meal_plan.name}, preferences is #{meal_plan.preferences}, goals is #{meal_plan.goals}, allergies is #{meal_plan.allergies}, cuisines is#{meal_plan.cuisines}, amounts is #{meal_plan.amounts}"
    meal_plan.response = chatgpt_service.generate_response(user_input)
    meal_plan.save!
    # render json: { meal_plan: response }
  end

end
