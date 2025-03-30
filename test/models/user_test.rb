# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  role            :enum             default("user"), not null
#  username        :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
require "test_helper"

class UserTest < ActiveSupport::TestCase
  context "validations" do
    setup do
      create(:user)
    end

    should validate_presence_of(:username)
    should validate_presence_of(:email)
    should validate_uniqueness_of(:email)
    should validate_presence_of(:password)
    should have_secure_password
    should validate_length_of(:password).is_at_least(8)
  end
end
