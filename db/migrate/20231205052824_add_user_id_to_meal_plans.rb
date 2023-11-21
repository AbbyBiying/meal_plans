class AddUserIdToMealPlans < ActiveRecord::Migration[7.1]
  def change
    add_reference :meal_plans, :user, foreign_key: true, default: nil
  end
end
