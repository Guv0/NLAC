class ConnectionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    true
  end

  def create?

  end

  def destroy?
    record.user == user
  end
end
