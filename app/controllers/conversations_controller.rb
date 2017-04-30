class ConversationsController < ApplicationController
  before_action :authenticate_user!
  skip_after_action :verify_policy_scoped, only: [ :index ]

  def index
    # @users = User.all
    # @conversations = Conversation.all
    @conversations = Conversation.where(sender_id: current_user.id).or(Conversation.where(recipient_id: current_user.id))
    @mailbox_props = []
    @conversations.each do |conversation|
      conversation.sender_id == current_user.id ? recipient = User.find(conversation.recipient_id) : recipient = User.find(conversation.sender_id)
      @mailbox_props << [conversation, recipient, recipient.business_card, conversation.messages]
    end
  end

  def create
    if Conversation.between(params[:sender_id],params[:recipient_id]).present?
      @conversation = Conversation.between(params[:sender_id],params[:recipient_id]).first
    else
      @conversation = Conversation.create!(conversation_params)
    end
    redirect_to conversation_messages_path(@conversation)
  end

  private

  def conversation_params
    params.require(:conversation).permit(:sender_id, :recipient_id)
  end
end
