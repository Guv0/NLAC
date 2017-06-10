class BusinessCardsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :show ]
  before_action :set_user, only: [ :destroy ]
  before_action :set_business_card, only: [ :show, :edit, :update, :destroy, :create_tags, :delete_tag ]

  def show
    if current_user
      @current_user = current_user
      @tags = @business_card.tags_to_display(@business_card.user_id, current_user.id)
      @connection = Connection.where(user_id: current_user.id, contact_id: @business_card.user_id).first
    elsif params[:live_guest_user]
      @current_user = User.find(params[:live_guest_user])
      @tags = @business_card.tags_for_guest(@business_card.user_id)
      # current_user = guest_user
    else
      # @current_user = User.new
      # @current_user.business_card = BusinessCard.new
      # @tags = @business_card.tags
      redirect_to new_user_registration_path
    end

  end

  def edit
  end

  def update
    @business_card.update(business_card_params)
    # @business_card.record_updates
    respond_to do |format|
      format.json  {render json: @business_card, status: :created}
      # format.html  redirect_to business_card_path(@business_card)
    end
  end

  def destroy
    @user.destroy
    redirect_to new_user_registration_path
  end

  def create_tags
    # binding.pry
      # normalized_tag = tag.split.join.downcase
    @tag_relation = TagRelation.new
    @tag_relation.add_tag(params["tag"], @business_card.id, current_user.id)
    # @business_card.record_tag_updates( params["tag"]) if @business_card.id == current_user.id

    @tags = @business_card.tags_to_display(@business_card.id, current_user.id)
    respond_to do |format|
        format.json { render json: @tags, status: :created }
    end
  end

  def delete_tag
    tag_id = params["deleteTag"]["id"]
    business_card_id = params["deleteTag"]["business_card_id"]
    creator_id = params["deleteTag"]["creator_id"]
    @tag_relation = TagRelation.where(tag_id: tag_id, business_card_id: business_card_id, creator_id: creator_id)

    TagRelation.destroy(@tag_relation.first.id)

    @tags = @business_card.tags_to_display(@business_card.user_id, current_user.id)

    respond_to do |format|
        format.json { render json: @tags, status: :created }
    end

  end

private

  def set_business_card
    @business_card = BusinessCard.find(params[:id])
    authorize @business_card
  end

  def set_user
    @user = @business_card.user
  end

  def business_card_params
    params.require(:business_card).permit(:first_name, :last_name, :email, :location, :phone, :industry, :company_name, :description, :photo, :photo_cache)
  end

end
