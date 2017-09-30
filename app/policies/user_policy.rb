class UserPolicy < ApplicationPolicy
  def index?
    user.role.sysadmin? || user.role.manager?
  end

  def show?
    user.role.sysadmin? || user.role.manager?
  end

  def create?
    user.role.sysadmin? || user.role.manager?
  end

  def new?
    user.role.sysadmin? || user.role.manager?
  end

  def update?
    user.role.sysadmin? || user.role.manager?
  end

  def edit?
    user.role.sysadmin? || user.role.manager?
  end

  def destroy?
    user.role.sysadmin?
  end
end
