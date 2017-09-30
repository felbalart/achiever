class PeriodPolicy < ApplicationPolicy
  def update?
    user.role.sysadmin?
  end

  def edit?
    update?
  end

  def set_as_current?
    update?
  end
end
