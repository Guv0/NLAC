class BusinessCardPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    record.user == user || user.contacts.ids.include?(record.id) ? true : false
  end

  def show?
    record.user == user || user.nil? || user.contacts.ids.include?(record.id) ? true : false
  end

  def update?
    record.user == user
  end

  def create?
    true
  end

  def create_tags?
    true
  end

  def delete_tag?
    true
  end


end
