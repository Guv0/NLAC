class Community < ApplicationRecord

has_many :members, through: :community_memberships, source: :user
# belongs_to :manager, -> { where(manager: true) }, class_name: "CommunityMembership"
has_many :community_memberships
has_many :community_messages

has_many :community_requests

has_many :events
validates_presence_of :name, :description, :photo
validates :description, length: { maximum: 200 }

include PgSearch
pg_search_scope :search_for, against: [:name, :description]

mount_uploader :photo, AvatarUploader

# after_create :send_creation_email

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
      managers << member if membership.manager
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

  private

  def send_creation_email
    CommunityMailer.creation(self).deliver_now
  end

end
