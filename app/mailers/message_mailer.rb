class MessageMailer < ApplicationMailer
   def new_message(message, conversation)
    @message = message
    @conversation = conversation
    conversation.recipient == message.user ? @recipient = @conversation.sender : @recipient = @conversation.recipient
    mail(
      to:       @recipient.email,
      subject:  "#{@message.user.business_card.first_name} sent you a message!"
    )
  end
end
