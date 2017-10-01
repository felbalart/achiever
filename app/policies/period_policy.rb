class PeriodPolicy < ApplicationPolicy

  def index?
    user.role.sysadmin?
  end

  def update?
    user.role.sysadmin?
  end

  def edit?
    update?
  end

  def new?
    create?
  end

  def create?
    user.role.sysadmin?
  end

  def set_as_current?
    update?
  end
end
