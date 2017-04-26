class ConnectionRequest < ApplicationRecord
  belongs_to :user
  has_one :contact, :foreign_key => :contact_id, class_name: 'User'
end
