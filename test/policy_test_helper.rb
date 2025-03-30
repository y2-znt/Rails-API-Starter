module PolicyTestHelper
  def permit_action(user, record, action)
    msg = "User #{user.inspect} should be permitted to #{action} #{record}, but isn't permitted"
    assert action_permitted?(user, record, action), msg
  end

  def forbid_action(user, record, action)
    msg = "User #{user.inspect} should NOT be permitted to #{action} #{record}, but is permitted"
    assert_not action_permitted?(user, record, action), msg
  end

  def action_permitted?(user, record, action)
    policy(user, record).public_send(:"#{action}?")
  end

  private

  def policy(user, record)
    cls = self.class.name.gsub(/Test$/, "")
    cls.constantize.new(user, record)
  rescue Pundit::NotAuthorizedError
    NilClassPolicy.new(user, record)
  end

  def policy_scope(user, scope)
    cls = self.class.name.gsub(/Test$/, "")
    cls.constantize::Scope.new(user, scope).resolve
  rescue Pundit::NotAuthorizedError
    NilClassPolicy::Scope.new(user, scope)
  end
end
