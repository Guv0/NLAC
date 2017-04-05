class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_filter :set_current_user
  after_filter :store_location

  def store_location
    return unless request.get?
    if (request.path != "/users/sign_in" &&
        request.path != "/users/sign_up" &&
        request.path != "/users/password/new" &&
        request.path != "/login" &&
        request.path != "/signup" &&
        request.path != "/users/password/edit" &&
        request.path != "/users/confirmation" &&
        request.path != "/users/sign_out" &&
        !request.xhr?) # don't store ajax calls
      session[:previous_url] = request.fullpath
    end
  end



  def after_sign_in_path_for(resource)

      session[:previous_url] || root_path
  end


private

  def set_current_user
    User.current = current_user
  end
end
