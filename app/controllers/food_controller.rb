class FoodController < ApplicationController
  def search
    response = Excon.post('https://platform.fatsecret.com',
      path: "rest/server.api",
      headers: { "Content-Type" => "application/x-www-form-urlencoded",
        "authorization": "Bearer #{fat_secret_bearer_token}"
      },
      body: URI.encode_www_form("content-type": 'application/json',
        method: 'foods.search',
        search_expression: params[:search_expression],
        format: "json"
      )
    )

    render json: JSON.parse(response.body)
  end
end
