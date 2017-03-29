class BusinessCardsController < ApplicationController

before_action :set_business_card, :set_user, only: [ :show, :edit, :update, :destroy ]

  def show
  end

  def edit
  end

  def update
    @business_card.update(business_card_params)
  end

  def destroy
    @user.destroy
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
