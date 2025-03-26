# == Schema Information
#
# Table name: groups
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class GroupTest < ActiveSupport::TestCase
  test "should save group with name" do
    group = Group.new(name: "Test Group")
    assert group.save, "Failed to save the group with a name"
  end
end
