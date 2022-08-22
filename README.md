# Meal Planner

This Ruby on Rails API allows users to search for nutirtion facts on food items using the FatSecret API and create meal schedules based on those facts.

## Getting Started
### Prerequisites

This app requires Ruby 3.0.x, Rails 7.x, Redis, and Postgres.

## API Endpoints

```
/food/search
```

### Parameters
Form URL Encoded

`search_expression`: string

### Example Request

curl --request GET \
  --url http://localhost:3000/food/search \
  --header 'Content-Type: application/x-www-form-urlencoded' \
  --data search_expression=toast
  
### Example Response

```
{
  "foods": {
    "food": [
      {
        "food_description": "Per 100g - Calories: 293kcal | Fat: 4.00g | Carbs: 54.40g | Protein: 9.00g",
        "food_id": "38821",
        "food_name": "Toasted White Bread",
        "food_type": "Generic",
        "food_url": "https:\/\/www.fatsecret.com\/calories-nutrition\/usda\/toasted-white-bread"
      },
      {
        "food_description": "Per 100g - Calories: 282kcal | Fat: 4.42g | Carbs: 51.32g | Protein: 9.95g",
        "food_id": "3591",
        "food_name": "Toasted Whole Wheat Bread",
        "food_type": "Generic",
        "food_url": "https:\/\/www.fatsecret.com\/calories-nutrition\/generic\/bread-whole-wheat-toasted"
      }
    ],
    "max_results": "2",
    "total_results": "520"
  }
}
```
