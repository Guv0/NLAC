class Message < ApplicationRecord

  belongs_to :conversation
  belongs_to :user

  validates_presence_of :body, :conversation_id, :user_id

  def message_time
    self.created_at.strftime("%-d %b '%y at %l:%M %p")
  end

  def sender
    User.find(self.user_id).business_card.full_name
  end
end
