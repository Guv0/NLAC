class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :set_business_card, only: [:after_sign_in_path_for]
  before_filter :set_current_user
  after_filter :store_location

  def store_location
    # store last url as long as it isn't a /users path
    session[:previous_url] = request.fullpath unless request.fullpath =~ /\/users/
  end



  def after_sign_in_path_for(resource)
    if session[:previous_url] =~ /\/business_cards/ && current_user.provider == nil
      redirect_to edit_business_card_path(@business_card.id)
    elsif session[:previous_url] =~ /\/business_cards/
      session[:previous_url] || root_path
    else
      instructions_path
    end
  end


private

  def set_current_user
    User.current = current_user
  end

  def set_business_card
    @business_card = BusinessCard.find(current_user.id)
  end
end
