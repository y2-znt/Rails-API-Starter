require "test_helper"

class Api::V1::GroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @group = groups(:one)
  end

  test "should get index" do
    get api_v1_groups_url, as: :json
    assert_response :success
  end

  test "should create group" do
    assert_difference("Group.count") do
      post api_v1_groups_url, params: { group: { name: @group.name } }, as: :json
    end

    assert_response :created
  end

  test "should show group" do
    get api_v1_group_url(@group), as: :json
    assert_response :success
  end

  test "should update group" do
    patch api_v1_group_url(@group), params: { group: { name: @group.name } }, as: :json
    assert_response :success
  end

  test "should destroy group" do
    assert_difference("Group.count", -1) do
      delete api_v1_group_url(@group), as: :json
    end

    assert_response :no_content
  end
end
