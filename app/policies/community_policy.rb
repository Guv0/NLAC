class CommunityPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    true
  end

  def show?
    record.members.include?(user)
  end

  def create?
    true
  end

  def edit?
    update?
  end

  def update?
    record.managers.include?(user)
  end

  def destroy?
    user.admin
  end

  def join_community?
    true
  end

end
