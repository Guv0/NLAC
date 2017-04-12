class BusinessCardPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def show?
    user.contacts.ids.include?(@record.id) ? true : false
  end
end
