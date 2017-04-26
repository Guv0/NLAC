class Community < ApplicationRecord

  belongs_to :owner, :foreign_key => :owner_id class_name: 'User'
  has_many :contacts, :foreign_key => :contact_ids, class_name: 'User'

end
