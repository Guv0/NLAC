class BusinessCard < ApplicationRecord
  belongs_to :user
  has_many :tag_relations, dependent: :destroy
  has_many :tags, through: :tag_relations
end
