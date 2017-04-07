class BusinessCard < ApplicationRecord

belongs_to :user
has_many :tag_relations, dependent: :destroy
has_many :tags, through: :tag_relations

include PgSearch
pg_search_scope :search_for, against: [:first_name, :last_name, :company_name, :industry, :location]

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

end
