class ConversationsController < ApplicationController
  before_action :authenticate_user!
  skip_after_action :verify_policy_scoped
  skip_after_action :verify_authorized

  def index
    # @users = User.all
    # @conversations = Conversation.all

    @conversations = Conversation.where(sender_id: current_user.id).or(Conversation.where(recipient_id: current_user.id))
    # @conversation_to_display = Conversation.where(sender_id: current_user.id, recipient_id: 6).or(Conversation.where(sender_id: 6, recipient_id: current_user.id))
    @conversation = Conversation.between(1, 6)
    @mailbox_props = [@conversation]
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

  def send_message
    @conversation = Conversation.find(params[:conversation_id])
    @message = Message.create(conversation_id: params[:conversation_id], user_id: current_user.id, body: params["message"])
    @message.sent_at = @message.message_time
    @message.save
    @conversation.sender_id == current_user.id ? recipient = User.find(@conversation.recipient_id) : recipient = User.find(@conversation.sender_id)
    conversation_props = [ @conversation, recipient, recipient.business_card, @conversation.messages ]
    respond_to do |format|
      format.json { render json: conversation_props, status: :created }
    end
  end

  def read_messages
    @messages = params[:messages]
    @messages.each do |message|
      Message.find(message).update(read: true)
    end
    @conversation = Conversation.find(params[:conversation_id])
    @conversation.sender_id == current_user.id ? recipient = User.find(@conversation.recipient_id) : recipient = User.find(@conversation.sender_id)
    conversation_props = [ @conversation, recipient, recipient.business_card, @conversation.messages ]

    respond_to do |format|
      format.json { render json: conversation_props, status: :created }
    end
  end

  private

  def conversation_params
    params.require(:conversation).permit(:sender_id, :recipient_id)
  end
end
