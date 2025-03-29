require "test_helper"

class Api::V1::MeControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = create(:user)
    @token = JsonWebToken.encode(user_id: @user.id)
    @headers = {"Authorization" => "Bearer #{@token}"}
  end

  def json_response
    JSON.parse(response.body)
  end

  test "should get current user" do
    get api_v1_me_path, headers: @headers
    assert_response :success
    assert_equal @user.id, json_response["id"]
  end

  test "should update user" do
    patch api_v1_me_path, params: {username: "new_username", email: "new_email@example.com"}, headers: @headers
    assert_response :no_content
  end

  test "should destroy current user" do
    assert_difference "User.count", -1 do
      delete api_v1_me_path, headers: @headers
    end
    assert_response :no_content
  end
end
