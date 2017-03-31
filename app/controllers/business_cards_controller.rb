class BusinessCardsController < ApplicationController

before_action :set_user, only: [ :destroy ]
before_action :set_business_card, :set_user, only: [ :show, :edit, :update, :destroy, :create_tags ]

  def show
    @tags = @business_card.tags_to_display(@business_card, @business_card.id, current_user.id)
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
      normalized_tag = tag.downcase
      @tag_relation = TagRelation.new
      @tag_relation.add_tag(normalized_tag, @business_card.id, current_user.id)
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
