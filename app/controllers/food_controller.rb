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

  private

  def fat_secret_bearer_token
    request = Excon.new("https://oauth.fatsecret.com",
      user: ENV["fat_secret_client_id"],
      password: ENV['fat_secret_client_secret']
    )

    response = request.post(
      path: "/connect/token",
      headers: { "Content-Type" => "application/x-www-form-urlencoded" },
      body: URI.encode_www_form("grant_type": 'client_credentials', scope: 'basic')
    )

    JSON.parse(response.body)['access_token']
  end
end
