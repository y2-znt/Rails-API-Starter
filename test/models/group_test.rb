require "test_helper"

class GroupTest < ActiveSupport::TestCase
  test "should save group with name" do
    group = Group.new(name: "Test Group")
    assert group.save, "Failed to save the group with a name"
  end
end
