class Community < ApplicationRecord

has_many :members, through: :community_memberships, source: :user
# belongs_to :owner, -> { where(owner: true) }, class_name: "CommunityMembership"
has_many :community_memberships

validates :description, length: { maximum: 200 }

include PgSearch
pg_search_scope :search_for, against: [:name, :description]

mount_uploader :photo, AvatarUploader

  def members
    community_memberships = CommunityMembership.where(community_id: self.id)
    members = []
    community_memberships.each do |membership|
      members << membership.member_id
    end
    User.find(members)
  end

  def managers
    managers = []
    self.members.each do |member|
      membership = member.community_memberships.where(community_id: self.id).first
      managers << member if membership.owner
    end
    managers
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
