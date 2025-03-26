# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  email      :string           not null
#  password   :string           not null
#  username   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @unique_email = "testuser_#{Time.now.to_i}@example.com"
  end

  def test_should_save_user
    user = User.new(username: "testuser", email: @unique_email, password: "password")
    assert user.save, "Failed to save the user"
  end

  def test_should_not_save_user_without_username
    user = User.new(email: @unique_email, password: "password")
    assert_not user.save, "Saved the user without a username"
  end

  def test_should_not_save_user_without_email
    user = User.new(username: "testuser3", password: "password")
    assert_not user.save, "Saved the user without an email"
  end

  def test_should_not_save_user_without_password
    user = User.new(username: "testuser4", email: @unique_email)
    assert_not user.save, "Saved the user without a password"
  end

  def test_should_not_save_user_with_duplicate_email
    User.create(username: "existinguser", email: @unique_email, password: "password")
    user = User.new(username: "testuser2", email: @unique_email, password: "password")
    assert_not user.save, "Saved the user with a duplicate email"
  end
end
