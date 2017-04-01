class ConnectionsController < ApplicationController

  def index
  end

  def create
    @connection = Connection.new(user_id: current_user.id, contact_id: params[:id])
    @connection.save
  end

  def root
    redirect_to business_card_connections_path(current_user)
  end

end
