class MessagesController < ApplicationController
  before_action :set_conversation
  skip_after_action :verify_policy_scoped
  skip_after_action :verify_authorized

  def index
    @messages = @conversation.messages
    if @messages.length > 10
      @over_ten = true
      @messages = @messages[-10..-1]
    end
    if params[:m]
      @over_ten = false
      @messages = @conversation.messages
    end
    if @messages.last
      if @messages.last.user_id != current_user.id
        @messages.last.read = true;
      end
    end
    @message = @conversation.messages.new
  end

  def new
    @message = @conversation.messages.new
  end

  # def create
  #   binding.pry
  #   @message = Message.new(conversation_id: params[:conversation_id], user_id: current_user.id, body: params["message"])
  #   @conversation.sender_id == current_user.id ? recipient = User.find(@conversation.recipient_id) : recipient = User.find(@conversation.sender_id)
  #   conversation_props = [ @conversation, recipient, recipient.business_card, @conversation.messages ]
  #   if @message.save
  #     respond_to do |format|
  #       format.json { render json: conversation_props, status: :created }
  #       format.html
  #     end
  #   end

  # end

  private

  def set_conversation
    @conversation = Conversation.find(params[:conversation_id])
  end

  def message_params
    params.require(:message).permit(:body, :user_id)
  end
end
