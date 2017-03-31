class Tag < ApplicationRecord
  has_many :tag_relations
  has_many :business_cards, through: :tag_relations

  def tags_to_display(business_card, owner_id, current_user_id)
    Tag.where(tag_id: @business_card.tag_relations.where(creator_id: owner_id).first.tag_id)
    business_card.tag_relations
end
