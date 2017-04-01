class BusinessCard < ApplicationRecord

belongs_to :user
has_many :tag_relations, dependent: :destroy
has_many :tags, through: :tag_relations

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def tags_to_display(business_card, owner_id, current_user_id)
    tags = []
    business_card.tag_relations.where(creator_id: owner_id).each do |relation|
      tags << Tag.find(relation.tag_id)
    end
    business_card.tag_relations.where(creator_id: current_user_id).each do |relation|
      tags << Tag.find(relation.tag_id)
    end
    return tags.uniq
  end

end
