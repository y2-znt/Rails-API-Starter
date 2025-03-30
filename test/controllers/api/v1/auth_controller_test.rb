require "test_helper"

class Api::V1::AuthControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user_params = attributes_for(:user)
    @user = create(:user)
    @token = JsonWebToken.encode(user_id: @user.id)
    @headers = {"Authorization" => "Bearer #{@token}"}
  end

  test "should register new user with valid params" do
    assert_difference("User.count", 1) do
      post api_v1_register_path, params: @user_params
    end

    assert_response :created
    assert_equal "User created successfully", JSON.parse(response.body)["message"]
  end

  test "should not register user with invalid params" do
    post api_v1_register_path, params: {email: "test@example.com", password: "short"}

    assert_response :unprocessable_entity
    response_errors = JSON.parse(response.body)["errors"]
    assert_includes response_errors, "Username can't be blank"
    assert_includes response_errors, "Password is too short (minimum is 8 characters)"
  end

  test "should login user with valid credentials" do
    post api_v1_login_path, params: {
      email: @user.email,
      password: "10nGpa55w0rd"
    }

    assert_response :ok
    assert_not_nil JSON.parse(response.body)["token"]
  end

  test "should not login user with invalid credentials" do
    post api_v1_login_path, params: {
      email: @user.email,
      password: "wrongpassword"
    }

    assert_response :unauthorized
    assert_equal "Invalid email or password", JSON.parse(response.body)["error"]
  end

  test "should not login with non-existent email" do
    post api_v1_login_path, params: {
      email: "nonexistent@example.com",
      password: "password123"
    }

    assert_response :unauthorized
    assert_equal "Invalid email or password", JSON.parse(response.body)["error"]
  end

  test "should logout user" do
    post api_v1_logout_path, headers: @headers
    assert_response :no_content
  end

  test "should not logout without authentication" do
    post api_v1_logout_path
    assert_response :unauthorized
  end
end
