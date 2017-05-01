class ConnectionRequestsController < ApplicationController
  before_action :set_connection_request, except: [ :index, :create ]
  skip_after_action :verify_policy_scoped
  skip_after_action :verify_authorized

  def index
    @incoming = ConnectionRequest.where(contact: current_user)
    @outgoing = current_user.connection_requests
  end

  def create
    contact = User.find(params[:business_card_id])
    @connection_request = current_user.pending_connections_requests.new(contact: contact, status: 'pending')
    @connection_request.save
    redirect_to :back
  end

  def update
    @connection_request.accept

    redirect_to user_path(@connection_request.connection)
  end

  def destroy
    @connection_request.destroy
  end

  private

  def set_connection_request
    @connection_request = ConnectionRequest.find(params[:id])
  end
end
