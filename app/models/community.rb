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

  def owner
    self.members.each do |member|
      membership = member.community_memberships.where(community_id: self.id).first
      return member if membership.owner
    end
  end

  def new_members
    array = []
    self.members do |member|
      membership = member.community_memberships.where(community_id: self.id).first
      if 1.hour.ago < membership.created_at
        array << member
      end
    end
    array
  end

end
