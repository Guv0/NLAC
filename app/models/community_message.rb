class CommunityMessage < ApplicationRecord
  belongs_to :manager, :foreign_key => :manager_id, class_name: 'User'
  belongs_to :community
end
