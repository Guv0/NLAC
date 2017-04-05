class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_filter :set_current_user

def after_sign_in_path_for(resource)
  request.env['omniauth.origin'] || stored_location_for(resource) || root_url
end

private

  def set_current_user
    User.current = current_user
  end
end
