class Tag < ApplicationRecord

has_many :tag_relations
has_many :business_cards, through: :tag_relations

scope :valid_tags, -> (business_card_id, current_user_id) { joins(:tag_relations).where('tag_relations.business_card_id = ? AND tag_relations.creator_id = ? OR tag_relations.business_card_id = ? AND tag_relations.creator_id = ?', business_card_id, business_card_id, business_card_id, current_user_id) }

include PgSearch
pg_search_scope :search_tag, against: :label

end
