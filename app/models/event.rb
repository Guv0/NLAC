class Event < ApplicationRecord
  belongs_to :community, :class_name => 'Community'
  has_one :organiser, :class_name => 'User'
  has_many :attendees, :class_name => 'User'
end
