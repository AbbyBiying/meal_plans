require_relative '../services/chat_gpt_service'
class MealPlan < ApplicationRecord
  after_create :generate_and_set_response

  private
    def generate_and_set_response
      chatgpt_service = ChatGPTService.new
      user_input = "user name is #{self.name}, preferences is #{self.preferences}, goals is #{self.goals}, allergies is #{self.allergies}, cuisines is#{self.cuisines}, amounts is #{self.amounts}"
      self.response = chatgpt_service.generate_response(user_input)

      self.save!
      render json: { meal_plan: response }
    end
end
