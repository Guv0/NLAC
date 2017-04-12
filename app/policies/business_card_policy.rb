class BusinessCardPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def show?
    record.user == user || user.contacts.ids.include?(record.id) ? true : false
  end
end
