class Connection < ApplicationRecord

belongs_to :user
belongs_to :contact, :foreign_key => :contact_id, class_name: 'User'

validates :user, presence: true
validates :contact, presence: true, uniqueness: { scope: :user }

end
