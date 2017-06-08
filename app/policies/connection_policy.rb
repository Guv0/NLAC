class ConnectionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    record.user == user || user.contacts.include?(record.user) ? true : false
  end

  def create?

  end

  def destroy?
    record.user == user
  end
end
