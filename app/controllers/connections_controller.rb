class ConnectionsController < ApplicationController

before_action :set_business_card, only: [ :index ]

  def index
  end

  def create
    @connection = Connection.new(user_id: current_user.id, contact_id: params[:id])
    @connection.save
  end

  def root
    redirect_to business_card_connections_path(current_user)
  end

private

def set_business_card
  @business_card = BusinessCard.find(params[:business_card_id])
end

end
