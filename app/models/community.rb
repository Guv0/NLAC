class Community < ApplicationRecord

has_many :members, through: :community_memberships, source: :user
# belongs_to :owner, -> { where(owner: true) }, class_name: "CommunityMembership"
has_many :community_memberships

validates :description, length: { maximum: 200 }

include PgSearch
pg_search_scope :search_for, against: [:name, :description]

mount_uploader :photo, AvatarUploader

  def members
    User.find(CommunityMembership.where(community_id: self.id).ids)
  end

end
