class ObjectivePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.role.sysadmin?
        scope.all
      else
        scope.where(user: user)
      end
    end
  end

  def index?
    # @objectives = policy_scope(Objective)
    @objectives = ObjectivePolicy::Scope.new(user, Objective).resolve
  end

  def show?
    scope.where(:id => record.id).exists?
  end

  def create?
    !Period.current.state.closed?
  end

  def new?
    !Period.current.state.closed?
  end

  def update?
    !Period.current.state.closed? && record.user == user
  end

  def edit?
    record.period.state.open? && record.user == user
  end

  def destroy?
    edit?
  end
end
