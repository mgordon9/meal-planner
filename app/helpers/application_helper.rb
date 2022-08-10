module ApplicationHelper
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
