class Event < ApplicationRecord
  belongs_to :community
  has_many :event_attendees
  has_one :organiser, :class_name => 'User'
  has_many :attendees, through: :event_attendees, source: :user

end
