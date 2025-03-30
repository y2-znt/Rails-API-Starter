require "test_helper"

class UserPolicyTest < ActiveSupport::TestCase
  def setup
    @user = create(:user)
    @admin_user = create(:user, :admin)
    @another_user = create(:user, email: "another@example.com")
  end

  # Tests for administrators
  test "admin should be allowed all actions" do
    permit_action(@admin_user, User, :index)
    permit_action(@admin_user, @user, :create)
    permit_action(@admin_user, @user, :show)
    permit_action(@admin_user, @user, :update)
    permit_action(@admin_user, @user, :destroy)
  end

  test "user should not be allowed to index" do
    forbid_action(@user, User, :index)
  end

  test "user should not be allowed to create" do
    forbid_action(@user, @another_user, :create)
  end

  test "user should only be allowed to show own profile" do
    permit_action(@user, @user, :show)
    forbid_action(@user, @another_user, :show)
  end

  test "user should only be allowed to update own profile" do
    permit_action(@user, @user, :update)
    forbid_action(@user, @another_user, :update)
  end

  test "user should not be allowed to destroy" do
    forbid_action(@user, @another_user, :destroy)
    forbid_action(@user, @user, :destroy)
  end
end
