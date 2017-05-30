class MessageMailerPreview < ActionMailer::Preview

  def new_message
    MessageMailer.new_message(Message.second, Conversation.first)
  end

end
