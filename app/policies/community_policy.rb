class CommunityPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def show?
    record.members.include?(user)
  end

  def create
    true
  end


end
