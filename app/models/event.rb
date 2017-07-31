class Event < ApplicationRecord
  belongs_to :community
  belongs_to :organiser
  belongs_to :attendees
end
