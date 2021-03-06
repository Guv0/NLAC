class BusinessCard < ApplicationRecord

belongs_to :user
has_many :tag_relations, dependent: :destroy
has_many :tags, through: :tag_relations

geocoded_by :location
after_validation :geocode, if: ->(business_card){ business_card.location.present? and business_card.location_changed? }

include PgSearch
pg_search_scope :search_for, against: [:first_name, :last_name, :location, :industry, :position, :company_name]

mount_uploader :photo, AvatarUploader

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def tags_to_display(owner_id, current_user_id)
    tags = []
    self.tag_relations.where(creator_id: owner_id).each do |relation|
      tags << [Tag.find(relation.tag_id), relation.creator_id]
    end
    self.tag_relations.where(creator_id: current_user_id).each do |relation|
      tags << [Tag.find(relation.tag_id), relation.creator_id]
    end
    return tags.uniq
  end

  def tags_for_guest(owner_id)
    tags = []
    self.tag_relations.where(creator_id: owner_id).each do |relation|
      tags << [Tag.find(relation.tag_id), relation.creator_id]
    end
    return tags
  end

  def record_updates
    updates = self.previous_changes
    self.updates << updates
    self.save
  end

  def record_tag_updates(normalized_tag)
    added_tag = {}
    added_tag["added_tag"] = ["", "#{normalized_tag}"]
    added_tag["updated_at"] = ["", DateTime.now]
    self.updates << added_tag
    self.save
  end
end
