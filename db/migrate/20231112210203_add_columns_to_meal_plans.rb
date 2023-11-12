class AddColumnsToMealPlans < ActiveRecord::Migration[7.1]
  def change
    add_column :meal_plans, :name, :string
    add_column :meal_plans, :preferences, :string
    add_column :meal_plans, :goals, :string
    add_column :meal_plans, :allergies, :string
    add_column :meal_plans, :cuisines, :string
    add_column :meal_plans, :amounts, :string
  end
end
