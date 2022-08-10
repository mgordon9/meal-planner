require "test_helper"

class MealsControllerTest < ActiveSupport::TestCase
  test "create a meal, query for each food and create foods for the meal" do
    stub_request(:post, "https://oauth.fatsecret.com/connect/token").
      to_return(status: 200, body: "{
        \"access_token\": \"token\",
        \"expires_in\": 86400,
        \"token_type\": \"Bearer\",
        \"scope\": \"basic\"
      }", headers: {})

    stub_request(:post, "https://platform.fatsecret.com/rest/server.api").
      with(
        body: {"food_id": "1", "format": "json", "method": "food.get.v2"},
        headers: {
        'Authorization': 'Bearer token',
        'Content-Type': 'application/x-www-form-urlencoded',
        'Host': 'platform.fatsecret.com:443'
        }).
      to_return(status: 200, headers: {}, body: {
        "food": {
          "food_id": "1",
          "servings": {
            "serving": [
              {
                "calories": "132",
                "carbohydrate": "24.48",
                "protein": "0",
                "fat": "1.80"
              }
            ]
          }
        }
      }.to_json)

    stub_request(:post, "https://platform.fatsecret.com/rest/server.api").
      with(
        body: {"food_id": "2", "format": "json", "method": "food.get.v2"},
        headers: {
        'Authorization': 'Bearer token',
        'Content-Type': 'application/x-www-form-urlencoded',
        'Host': 'platform.fatsecret.com:443'
        }).
      to_return(status: 200, headers: {}, body: {
        "food": {
          "food_id": "2",
          "servings": {
            "serving": [
              {
                "calories": "100",
                "carbohydrate": "34.56",
                "protein": "6.5",
                "fat": "3.55"
              }
            ]
          }
        }
      }.to_json)

    schedule = Schedule.create

    MealCreatorWorker.new.perform(schedule.id, ["1", "2"])

    assert_equal(1, Meal.count)
    assert_equal(2, Food.count)

    assert_equal(1, schedule.meals.count)
    assert_equal(2, schedule.meals.first.foods.count)
  end
end
