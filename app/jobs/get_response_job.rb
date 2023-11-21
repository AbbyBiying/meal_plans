require_relative '../services/chat_gpt_service'

class GetResponseJob < ApplicationJob
  queue_as :default

  def perform(meal_plan_id)
    meal_plan = MealPlan.find(meal_plan_id)
    chatgpt_service = ChatGPTService.new

    user_input = "user name is #{meal_plan.name}, preferences is #{meal_plan.preferences}, goals is #{meal_plan.goals}, allergies is #{meal_plan.allergies}, cuisines is #{meal_plan.cuisines}, amounts is #{meal_plan.amounts}"

    meal_plan.response = chatgpt_service.generate_response(user_input)

    if meal_plan.save
      Rails.logger.info("MealPlan ##{meal_plan.id} updated successfully.")
    else
      Rails.logger.error("Failed to update MealPlan ##{meal_plan.id}. Validation errors: #{meal_plan.errors.full_messages}")
    end
  end
end
