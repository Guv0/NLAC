class Event < ApplicationRecord
  belongs_to :community
  has_many :event_attendees
  has_many :attendees, through: :event_attendees, source: :user
end
