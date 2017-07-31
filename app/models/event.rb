class Event < ApplicationRecord
  belongs_to :community
  has_one :organiser, :class_name => 'User'
  has_many :attendees, :class_name => 'User', through: :communities
end
