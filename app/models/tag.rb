class Tag < ApplicationRecord
  has_many :tag_relations
  has_many :business_cards, through: :tag_relations
end
