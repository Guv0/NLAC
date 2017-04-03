class BusinessCardsController < ApplicationController

before_action :set_user, only: [ :destroy ]
before_action :set_business_card, :set_user, only: [ :show, :edit, :update, :destroy, :create_tags, :delete_tag ]

  def show
    @tags = @business_card.tags_to_display(@business_card, @business_card.id, current_user.id)
    @current_user = current_user
  end

  def edit
  end

  def update
    if @business_card.update(business_card_params)
      redirect_to business_card_path(@business_card)
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to new_user_registration_path
  end

  def create_tags
    params["tags"].each do |tag|
      normalized_tag = tag.split.join.downcase
      @tag_relation = TagRelation.new
      @tag_relation.add_tag(normalized_tag, @business_card.id, current_user.id)
    end
    @tags = @business_card.tags_to_display(@business_card, @business_card.id, current_user.id)
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

    @tags = @business_card.tags_to_display(@business_card, @business_card.id, current_user.id)

    respond_to do |format|
        format.json { render json: @tags, status: :created }
    end
    # redirect_to business_card_path(@business_card)
  end

private

  def set_business_card
    @business_card = BusinessCard.find(params[:id])
  end

  def set_user
    @user = @business_card.user
  end

  def business_card_params
    params.require(:business_card).permit(:first_name, :last_name, :email, :location, :phone, :industry, :company_name, :description, :photo, :photo_cache)
  end

end
