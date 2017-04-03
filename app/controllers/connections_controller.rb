class ConnectionsController < ApplicationController

helper_method :sort_column, :sort_direction

  def index
    contacts_ids =  current_user.contacts do |contact|
                      contact.id
                    end
    @contacts = BusinessCard.where(user_id: contacts_ids).order(sort_column + ' ' + sort_direction)
  end

  def create
    @connection = Connection.new(user_id: current_user.id, contact_id: params[:id])
    @connection.save
  end

  def root
    redirect_to business_card_connections_path(current_user)
  end

private

  def sort_column
    BusinessCard.column_names.include?(params[:sort]) ? params[:sort] : "last_name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
  end

end

