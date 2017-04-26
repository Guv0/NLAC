class Community < ApplicationRecord

  has_many :members, through: :community_memberships, source: :user
  # belongs_to :owner, -> { where(owner: true) }, class_name: "CommunityMembership"


end
