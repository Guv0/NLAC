class TagRelation < ApplicationRecord
  belongs_to :business_card
  belongs_to :tag
end
