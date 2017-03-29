class BusinessCard < ApplicationRecord
  belongs_to :user
  has_many :tag_relations, dependent: :destroy
  has_many :tags, through: :tag_relations

  def full_name
    "#{self.first_name} #{self.last_name}"
  end
end
