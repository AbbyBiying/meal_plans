class AddResponseToMealPlans < ActiveRecord::Migration[7.1]
  def change
    add_column :meal_plans, :response, :string
  end
end
