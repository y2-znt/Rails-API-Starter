require "test_helper"

class Api::V1::AuthControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user_params = {
      username: "testuser",
      email: "test@example.com",
      password: "password123"
    }
  end

  test "should register new user with valid params" do
    assert_difference("User.count") do
      post api_v1_auth_register_path, params: @user_params
    end

    assert_response :created
    assert_equal "User created successfully", JSON.parse(response.body)["message"]
  end

  test "should not register user with invalid params" do
    post api_v1_auth_register_path, params: {email: "test@example.com", password: "short"}

    assert_response :unprocessable_entity
    response_errors = JSON.parse(response.body)["errors"]
    assert_includes response_errors, "Username can't be blank"
    assert_includes response_errors, "Password is too short (minimum is 8 characters)"
  end

  test "should login user with valid credentials" do
    User.create!(@user_params)

    post api_v1_auth_login_path, params: {
      email: @user_params[:email],
      password: @user_params[:password]
    }

    assert_response :ok
    assert_not_nil JSON.parse(response.body)["token"]
  end

  test "should not login user with invalid credentials" do
    User.create!(@user_params)

    post api_v1_auth_login_path, params: {
      email: @user_params[:email],
      password: "wrongpassword"
    }

    assert_response :unauthorized
    assert_equal "Invalid email or password", JSON.parse(response.body)["error"]
  end

  test "should not login with non-existent email" do
    post api_v1_auth_login_path, params: {
      email: "nonexistent@example.com",
      password: "password123"
    }

    assert_response :unauthorized
    assert_equal "Invalid email or password", JSON.parse(response.body)["error"]
  end
end
