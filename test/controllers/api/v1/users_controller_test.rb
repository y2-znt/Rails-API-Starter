require "test_helper"

class Api::V1::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @unique_email = "testuser_#{Time.now.to_i}@example.com"
  end

  def test_should_get_index
    get api_v1_users_url, as: :json
    assert_response :success
  end

  def test_should_create_user
    assert_difference("User.count") do
      post api_v1_users_url, params: { user: { email: @unique_email, password: @user.password, username: @user.username } }, as: :json
    end

    assert_response :created
  end

  def test_should_show_user
    get api_v1_user_url(@user), as: :json
    assert_response :success
  end

  def test_should_update_user
    patch api_v1_user_url(@user), params: { user: { email: @unique_email, password: @user.password, username: @user.username } }, as: :json
    assert_response :success
  end

  def test_should_destroy_user
    assert_difference("User.count", -1) do
      delete api_v1_user_url(@user), as: :json
    end

    assert_response :no_content
  end
end
