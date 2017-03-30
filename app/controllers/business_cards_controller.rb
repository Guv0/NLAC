class BusinessCardsController < ApplicationController

before_action :set_business_card, :set_user, only: [ :show, :edit, :update, :destroy, :create_tags ]

  def show
    @tags = @business_card.tags
  end

  def edit
  end

  def update
    @business_card.update(business_card_params)
  end

  def destroy
    @user.destroy
  end

  def create_tags
    params["tags"].each do |tag|
      normalized_tag = tag.downcase
      if Tag.where(label: normalized_tag) && TagRelation.where(tag_id: Tag.where(label: normalized_tag).first.id, business_card_id: @business_card.id) == nil
        existing_tag = Tag.where(label: normalized_tag).first
        TagRelation.create(tag_id: existing_tag.id, business_card_id: @business_card.id, creator_id: current_user.id)
      elsif Tag.where(label: normalized_tag) == nil
        Tag.create(label: normalized_tag)
        TagRelation.create(tag_id: Tag.where(label: normalized_tag).first.id, business_card_id: @business_card.id, creator_id: current_user.id)
      end
    end
  end

private

  def set_business_card
    @business_card = BusinessCard.find(params[:id])
  end

  def set_user
    @user = @business_card.user
  end

  def business_card_params
    params.require(:business_card).permit(:first_name, :last_name, :email, :location, :phone, :industry, :company_name, :description)
  end

end
