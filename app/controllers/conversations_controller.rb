class ConversationsController < ApplicationController
  before_action :authenticate_user!
  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped

  def index
    conversations = Conversation.where(sender_id: current_user.id).or(Conversation.where(recipient_id: current_user.id))
    @conversations_sorted = conversations.order({last_message: :desc})
    if params[:active_conversation].present?
      @active_conversation = Conversation.find(params[:active_conversation].to_i)
    else
      @active_conversation = @conversations_sorted.first
    end
    if @active_conversation == nil
      @notification = "You don't currently have any conversations. If you want to message someone, please find them in your contacts or communities."
    else
      @active_conversation.sender_id == current_user.id ? active_recipient = User.find(@active_conversation.recipient_id) : active_recipient = User.find(@active_conversation.sender_id)
      @active_conversation_props = [@active_conversation, active_recipient, active_recipient.business_card, @active_conversation.messages.sort]

      @mailbox_props = []
      @conversations_sorted.each do |conversation|
        conversation.sender_id == current_user.id ? recipient = User.find(conversation.recipient_id) : recipient = User.find(conversation.sender_id)
        @mailbox_props << [conversation, recipient, recipient.business_card, conversation.messages.sort]
      end
    end
  end

  def create
    if Conversation.between(params[:sender_id],params[:recipient_id]).present?
      @active_conversation = Conversation.between(params[:sender_id],params[:recipient_id]).first
      @active_conversation.update(last_message: DateTime.now)
    else
      @active_conversation = Conversation.create!(sender_id: params[:sender_id], recipient_id: params[:recipient_id], last_message: DateTime.now)
      @active_conversation.started_on = @active_conversation.started_on
      @active_conversation.save
    end
    respond_to do |format|
      format.json { render json: @active_conversation, status: :created }
      format.html { redirect_to conversations_path(active_conversation: @active_conversation) }
    end

  end

  def send_message
    @conversation = Conversation.find(params[:conversation_id])
    @message = Message.create(conversation_id: params[:conversation_id], user_id: current_user.id, body: params["message"])
    @message.sent_at = @message.message_time
    @message.sender = @message.sender_name
    @message.save
    MessageMailer.new_message(@message, @conversation).deliver_now
    @conversation.update(last_message: DateTime.now)
    @conversation.sender_id == current_user.id ? recipient = User.find(@conversation.recipient_id) : recipient = User.find(@conversation.sender_id)
    conversation_props = [ @conversation, recipient, recipient.business_card, @conversation.messages.sort ]
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
