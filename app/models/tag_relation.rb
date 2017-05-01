class TagRelation < ApplicationRecord

belongs_to :business_card
belongs_to :tag

  def valid_tag_relation?(business_card_id, current_user_id)
    if ((self.creator_id == business_card_id) || (self.creator_id == current_user_id))
      return true
    end
  end

  def add_tag(normalized_tag, business_card_id, current_user_id)
    if Tag.where(label: normalized_tag) == []
      Tag.create(label: normalized_tag)
      TagRelation.create(tag_id: Tag.last.id, business_card_id: business_card_id, creator_id: current_user_id)
    elsif TagRelation.where(tag_id: Tag.where(label: normalized_tag).first.id, business_card_id: business_card_id) == []
      TagRelation.create(tag_id: Tag.where(label: normalized_tag).first.id, business_card_id: business_card_id, creator_id: current_user_id)
    elsif TagRelation.where(tag_id: Tag.where(label: normalized_tag).first.id, business_card_id: business_card_id, creator_id: business_card_id) == []
      TagRelation.create(tag_id: Tag.where(label: normalized_tag).first.id, business_card_id: business_card_id, creator_id: current_user_id)
    end
  end
end
