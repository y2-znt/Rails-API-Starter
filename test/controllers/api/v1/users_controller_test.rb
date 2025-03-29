require "test_helper"

class Api::V1::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)
  end

  test "should return all users" do
    # Create users with unique emails
    create(:user, email: "user1@example.com")
    create(:user, email: "user2@example.com")
    create(:user, email: "user3@example.com")
    
    get api_v1_users_path
    assert_response :success
    
    response_body = JSON.parse(response.body)
    assert_equal User.count, response_body.length
  end

  test "should show user" do
    get api_v1_user_path(@user)
    assert_response :success

    response_body = JSON.parse(response.body)
    assert_equal @user.id, response_body['id']
  end

  test "should create user" do
    assert_difference('User.count') do
      post api_v1_users_path, params: {
        username: 'testuser',
        email: 'test@example.com',
        password: 'password123'
      }
    end

    assert_response :created
    response_body = JSON.parse(response.body)
    assert_equal "testuser", response_body["username"]
    assert_equal "test@example.com", response_body["email"]
  end

  test "should not create user with invalid params" do
    assert_no_difference("User.count") do
      post api_v1_users_path, params: {
        username: "",
        email: "invalid_email",
        password: ""
      }
    end

    assert_response :unprocessable_entity
  end

  test "should update user" do
    patch api_v1_user_path(@user), params: {
      username: "updated_username",
      password: "newpassword123"
    }
    assert_response :no_content

    @user.reload
    assert_equal "updated_username", @user.username
  end

  test "should not update user with invalid params" do
    original_username = @user.username
    patch api_v1_user_path(@user), params: {
      username: "",
      password: ""
    }
    assert_response :unprocessable_entity

    @user.reload
    assert_equal original_username, @user.username
  end

  test "should destroy user" do
    assert_difference("User.count", -1) do
      delete api_v1_user_path(@user)
    end

    assert_response :no_content
  end

  test "should return not found for non-existent user" do
    get api_v1_user_path(id: "nonexistent")
    assert_response :not_found
  end
end
