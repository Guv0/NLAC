class ConnectionsController < ApplicationController
skip_before_action :authenticate_user!, only: [ :create ]
before_action :set_business_card, only: [ :index, :create ]
skip_after_action :verify_policy_scoped, only: [ :index ]
skip_after_action :verify_authorized, only: [ :root ]
helper_method :sort_column, :sort_direction

  def index
    contacts_ids =  @business_card.user.contacts do |contact|
                      contact.id
                    end

    if params[:query].present? && params[:search].present?
      tags = Tag.valid_tags(@business_card.id, current_user.id).search_tag(params[:search])
      business_cards_tags = []
      tags.each do |tag|
        business_cards_tags << tag.tag_relations.first.business_card
      end

      business_cards = BusinessCard.where(user_id: contacts_ids).search_for(params[:query])
      @contacts = business_cards_tags.concat(business_cards).uniq
    elsif params[:query].present?
      @contacts = BusinessCard.where(user_id: contacts_ids).search_for(params[:query]).sort_by { |e| e.first_name }
    elsif params[:search].present?
      tags = Tag.valid_tags(@business_card.id, current_user.id).search_tag(params[:search])
      business_cards_tags = []
      tags.each do |tag|
        business_cards_tags << tag.tag_relations.first.business_card
      end
      @contacts = business_cards_tags
    else
      @contacts = BusinessCard.where(user_id: contacts_ids)
    end

  end

  def create
    if current_user
      @connection = Connection.new(user_id: current_user.id, contact_id: params[:business_card_id])
      @connection.save
      redirect_to business_card_path(@business_card)
    else
      redirect_to business_card_path(@business_card)
    end
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

  def set_business_card
    @business_card = BusinessCard.find(params[:business_card_id])
    authorize @business_card
  end

end

