class BusinessCardPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def show?
    record.user == user || user.contacts.include?(record.user) ? true : false
  end

  def edit?
    update?
  end

  def update?
    record.user == user
  end

  def destroy?
    record.user == user
  end

  def create_tags
    record.user == user || user.contacts.include?(record.user) ? true : false
  end

  def delete_tag
    record.user == user || user.contacts.include?(record.user) ? true : false
  end
end
