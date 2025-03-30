class UserPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def create?
    user.admin?
  end

  def show?
    user.admin? || record.id == user.id
  end

  def update?
    user.admin? || record.id == user.id
  end

  def destroy?
    user.admin?
  end
end
