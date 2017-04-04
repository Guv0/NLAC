class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_filter :set_current_user

private

  def set_current_user
    User.current = current_user
  end
end
