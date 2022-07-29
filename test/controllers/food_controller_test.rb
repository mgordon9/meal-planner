require "test_helper"

class FoodControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    stub_request(:post, "https://oauth.fatsecret.com/connect/token").
      to_return(status: 200, body: "{
        \"access_token\": \"token\",
        \"expires_in\": 86400,
        \"token_type\": \"Bearer\",
        \"scope\": \"basic\"
      }", headers: {})

    stub_request(:post, "https://platform.fatsecret.com/rest/server.api").
      with(
        body: {"content-type": "application/json", "format": "json", "method": "foods.search", "search_expression": "toast"},
        headers: {
        'Authorization': 'Bearer token',
        'Content-Type': 'application/x-www-form-urlencoded',
        'Host': 'platform.fatsecret.com:443'
        }).
      to_return(status: 200, body: "{\"some_stuff\": \"food\"}", headers: {})

    get("/food/search", params: { search_expression: "toast" } )
    assert_response :success

    assert_equal({"some_stuff": "food"}.stringify_keys, JSON.parse(response.body))
  end
end
