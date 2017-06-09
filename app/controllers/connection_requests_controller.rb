class ConnectionRequestsController < ApplicationController
  before_action :set_connection_request, except: [ :index, :create ]
  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped

  def index
    @contacts_incoming = current_user.connection_requests
    @contacts_outgoing = current_user.pending_connections_requests
    @community_requests = current_user.community_requests
    @community_requests_as_manager = current_user.community_requests_as_manager
  end

  def create
    contact = User.find(params[:business_card_id])
    @connection_request = current_user.pending_connections_requests.new(contact: contact, status: 'pending')
    @connection_request.save
    redirect_to :back
  end

  def update
    @connection_request.accept
    redirect_to :back
  end

  def destroy
    @connection_request.destroy
    redirect_to :back
  end

  private

  def set_connection_request
    @connection_request = ConnectionRequest.find(params[:id])
  end
end
