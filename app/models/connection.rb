class Connection < ApplicationRecord

belongs_to :user
belongs_to :contact, class_name: 'User'

validates :user, presence: true
validates :contact, presence: true, uniqueness: { scope: :user }

end
