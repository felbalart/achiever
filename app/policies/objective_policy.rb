class ObjectivePolicy < ApplicationPolicy
  def index?
    true
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
    update?
  end
end
