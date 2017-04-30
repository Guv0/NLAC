class ConnectionsController < ApplicationController
skip_before_action :authenticate_user!, only: [ :create, :guest_connection ]
before_action :set_business_card, only: [ :index, :create ]
# skip_after_action :verify_policy_scoped, only: [ :index ]
# skip_after_action :verify_authorized, only: [ :root, :guest_connection, :omnicontacts_index ]
helper_method :sort_column, :sort_direction
  skip_after_action :verify_policy_scoped
  skip_after_action :verify_authorized
  def index
    contacts_ids =  @business_card.user.contacts do |contact|
                      contact.id
                    end

    if params[:query].present? && params[:search].present?
      business_cards_query = BusinessCard.where(user_id: contacts_ids).search_for(params[:query])
      search = params[:search].split(' ')
      valid_tags_search = []
      search.each do |keyword|
        business_cards_query.each do |business_card|
          valid_tags_search << Tag.valid_tags(business_card.id, current_user.id).search_tag(keyword)
        end
      end
      business_cards_search = []
      valid_tags_search.flatten.each do |tag|
      tag.tag_relations.where(business_card_id: contacts_ids).each do |tag_relation|
        business_cards_search << tag_relation.business_card
      end
      end
      @contacts = business_cards_query & business_cards_search.sort_by { |e| e.first_name }
    elsif params[:query].present?
      @contacts = BusinessCard.where(user_id: contacts_ids).search_for(params[:query]).sort_by { |e| e.first_name }
    elsif params[:search].present?
      search = params[:search].split(' ')
      valid_tags_search = []
      search.each do |keyword|
        @business_card.user.contacts.each do |contact|
          valid_tags_search << Tag.valid_tags(contact.id, current_user.id).search_tag(keyword)
        end
      end
      @contacts = []
      valid_tags_search.flatten.each do |tag|
        tag.tag_relations.where(business_card_id: contacts_ids).each do |tag_relation|
          @contacts << tag_relation.business_card
        end
      end
      @contacts = @contacts.uniq.sort_by { |e| e.first_name }
    else
      @contacts = BusinessCard.where(user_id: contacts_ids).sort_by { |e| e.first_name }
    end
    @gmail_contacts = request.env['omnicontacts.contacts']
      respond_to do |format|
        format.html
      end
  end

  def create
    current_or_guest_user
    if current_user
      @connection = Connection.new(user_id: current_user.id, contact_id: params[:business_card_id])
      @connection.save
      flash[:notice] = "#{BusinessCard.find(params[:business_card_id]).first_name} is now in your contacts"
      redirect_to business_card_path(@business_card)
    else

      @live_guest_user = guest_user

      redirect_to business_card_path(@business_card, live_guest_user: @live_guest_user)
    end
  end

  def guest_connection
    Connection.create(user_id: session[:guest_user_id], contact_id: params[:business_card_id])
    current_user = guest_user
    redirect_to new_user_registration_path
  end

  def root
    redirect_to business_card_connections_path(current_user)
  end

  # def contact_callback
  #   @contacts = request.env[‘omnicontacts.contacts’]
  #   @user = request.env[‘omnicontacts.user’]
  #   puts “List of contacts of {user[:name]} obtained from params[:importer]}:”
  #   @contacts.each do|contact|
  #   puts “Contact found: name => {contact[:name]}, email => {contact[:email]}”
  #   end
  # end

  def omnicontacts_index
    @contacts = request.env['omnicontacts.contacts']
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
    # authorize @business_card
  end

end

