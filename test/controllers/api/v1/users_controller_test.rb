require "test_helper"

class Api::V1::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_user = create(:user, :admin)
    @user = create(:user)
    @admin_token = JsonWebToken.encode(user_id: @admin_user.id)
    @user_token = JsonWebToken.encode(user_id: @user.id)
    @admin_headers = {"Authorization" => "Bearer #{@admin_token}"}
    @user_headers = {"Authorization" => "Bearer #{@user_token}"}
  end

  test "should return all users when admin" do
    get api_v1_users_path, headers: @admin_headers
    assert_response :success

    response_body = JSON.parse(response.body)
    assert_equal User.count, response_body.length
  end

  test "should not return all users when regular user" do
    get api_v1_users_path, headers: @user_headers
    assert_response :forbidden
  end

  test "should show own user profile" do
    get api_v1_user_path(@user), headers: @user_headers
    assert_response :success

    response_body = JSON.parse(response.body)
    assert_equal @user.id, response_body["id"]
  end

  test "admin should show any user profile" do
    get api_v1_user_path(@user), headers: @admin_headers
    assert_response :success

    response_body = JSON.parse(response.body)
    assert_equal @user.id, response_body["id"]
  end

  test "should not show other user profile when regular user" do
    other_user = create(:user, email: "other@example.com")
    get api_v1_user_path(other_user), headers: @user_headers
    assert_response :forbidden
  end

  test "admin should create user" do
    assert_difference("User.count") do
      post api_v1_users_path,
        headers: @admin_headers,
        params: {
          username: "testuser",
          email: "test@example.com",
          password: "password123"
        }
    end

    assert_response :created
    response_body = JSON.parse(response.body)
    assert_equal "testuser", response_body["username"]
    assert_equal "test@example.com", response_body["email"]
  end

  test "regular user should not create user" do
    assert_no_difference("User.count") do
      post api_v1_users_path,
        headers: @user_headers,
        params: {
          username: "testuser",
          email: "test@example.com",
          password: "password123"
        }
    end

    assert_response :forbidden
  end

  test "should not create user with invalid params" do
    assert_no_difference("User.count") do
      post api_v1_users_path,
        headers: @admin_headers,
        params: {
          username: "",
          email: "invalid_email",
          password: ""
        }
    end

    assert_response :unprocessable_entity
  end

  test "should update own user profile" do
    patch api_v1_user_path(@user),
      headers: @user_headers,
      params: {
        username: "updated_username",
        password: "newpassword123"
      }
    assert_response :no_content

    @user.reload
    assert_equal "updated_username", @user.username
  end

  test "admin should update any user" do
    patch api_v1_user_path(@user),
      headers: @admin_headers,
      params: {
        username: "admin_updated",
        password: "newpassword123"
      }
    assert_response :no_content

    @user.reload
    assert_equal "admin_updated", @user.username
  end

  test "should not update other user profile when regular user" do
    other_user = create(:user, email: "other@example.com")
    original_username = other_user.username

    patch api_v1_user_path(other_user),
      headers: @user_headers,
      params: {
        username: "hacked",
        password: "hacked123"
      }
    assert_response :forbidden

    other_user.reload
    assert_equal original_username, other_user.username
  end

  test "should not update user with invalid params" do
    original_username = @user.username
    patch api_v1_user_path(@user),
      headers: @user_headers,
      params: {
        username: "",
        password: ""
      }
    assert_response :unprocessable_entity

    @user.reload
    assert_equal original_username, @user.username
  end

  test "admin should destroy user" do
    assert_difference("User.count", -1) do
      delete api_v1_user_path(@user), headers: @admin_headers
    end

    assert_response :no_content
  end

  test "regular user should not destroy user" do
    assert_no_difference("User.count") do
      delete api_v1_user_path(@user), headers: @user_headers
    end

    assert_response :forbidden
  end

  test "should return not found for non-existent user" do
    get api_v1_user_path(id: "nonexistent"), headers: @admin_headers
    assert_response :not_found
  end
end
