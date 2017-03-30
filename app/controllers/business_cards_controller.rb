class BusinessCardsController < ApplicationController

before_action :set_business_card, only: [ :show, :edit, :update, :destroy ]
before_action :set_user, only: [ :destroy ]

  def show
    @tags = @business_card.tags
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
