class Message < ApplicationRecord

  belongs_to :conversation
  belongs_to :user

  validates_presence_of :body, :conversation_id, :user_id

  def message_time
    self.created_at.strftime("%Y/%m/%d at %l:%M %P")
  end

  def sender_name
    User.find(self.user_id).business_card.full_name
  end
end
