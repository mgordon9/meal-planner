class MealCreatorWorker
  include ApplicationHelper
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(schedule_id, fat_secret_food_ids)
    schedule = Schedule.find(schedule_id)
    foods_nutrition_facts = fat_secret_food_ids.map do |fat_secret_food_id|
      food_nutrition_facts = get_nutrition_facts(fat_secret_food_id)
      {
        fat_secret_food_id: fat_secret_food_id,
        calories: food_nutrition_facts[:calories],
        carbohydrates: food_nutrition_facts[:carbohydrates],
        fat: food_nutrition_facts[:fat],
        protein: food_nutrition_facts[:protien]
      }
    end

    meal = schedule.meals.create
    foods_nutrition_facts.each do |nutrition_facts|
      meal.foods.create(nutrition_facts)
    end
  end

  def get_nutrition_facts(fat_secret_food_id)
    response = Excon.post('https://platform.fatsecret.com',
      path: "rest/server.api",
      headers: { "Content-Type" => "application/x-www-form-urlencoded",
        "authorization": "Bearer #{fat_secret_bearer_token}"
      },
      body: URI.encode_www_form(
        method: 'food.get.v2',
        food_id: fat_secret_food_id,
        format: "json"
      )
    )

    food = JSON.parse(response.body)["food"]["servings"]["serving"].first
    {
      calories: food["calories"],
      fat: food["fat"],
      protein: food["protein"],
      carbohydrates: food["carbohydrates"]
    }
  end
end
