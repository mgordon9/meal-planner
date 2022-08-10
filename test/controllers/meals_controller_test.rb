require "test_helper"

class MealsControllerTest < ActionDispatch::IntegrationTest
  test "perform creator worker and return 200" do
    MealCreatorWorker.expects(:perform_async).once

    schedule = Schedule.create
    post("/schedules/#{schedule.id}/meals", params: { fat_secret_food_ids: ["1", "2"] }, as: :json )


    assert_response :success
  end
end
