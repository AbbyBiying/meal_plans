require "test_helper"

class MealPlansControllerTest < ActionDispatch::IntegrationTest
  setup do
    @meal_plan = meal_plans(:one)
  end

  test "should get index" do
    get meal_plans_url, as: :json
    assert_response :success
  end

  test "should create meal_plan" do
    assert_difference("MealPlan.count") do
      post meal_plans_url, params: { meal_plan: { description: @meal_plan.description, name: @meal_plan.name } }, as: :json
    end

    assert_response :created
  end

  test "should show meal_plan" do
    get meal_plan_url(@meal_plan), as: :json
    assert_response :success
  end

  test "should update meal_plan" do
    patch meal_plan_url(@meal_plan), params: { meal_plan: { description: @meal_plan.description, name: @meal_plan.name } }, as: :json
    assert_response :success
  end

  test "should destroy meal_plan" do
    assert_difference("MealPlan.count", -1) do
      delete meal_plan_url(@meal_plan), as: :json
    end

    assert_response :no_content
  end
end
