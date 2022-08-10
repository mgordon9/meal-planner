class MealsController < ApplicationController
  def create
    request_body = JSON.parse(request.body.read)
    fat_secret_food_ids = request_body["fat_secret_food_ids"]

    MealCreatorWorker.perform_async(params[:schedule_id], fat_secret_food_ids)

    head :ok
  end
end
