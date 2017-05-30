class CommunityRequest < ApplicationRecord

belongs_to :user
belongs_to :community

validates :user, presence: true
validates :community, presence: true

def accept
  CommunityMembership.create(member_id: self.user_id, community_id: self.community_id)
  destroy
end

end
