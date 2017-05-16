class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  # after_filter :store_location


    # if user is logged in, return current_user, else return guest_user
  def current_or_guest_user
    if current_user
      if session[:guest_user_id] && session[:guest_user_id] != current_user.id
        logging_in
        # reload guest_user to prevent caching problems before destruction
        guest_user(with_retry = false).reload.try(:destroy)
        session[:guest_user_id] = nil
      end
      current_user
    else
      guest_user
    end
  end

  # find guest_user object associated with the current session,
  # creating one as needed
  def guest_user(with_retry = true)
    # Cache the value the first time it's gotten.
    @cached_guest_user ||= User.find(session[:guest_user_id] ||= create_guest_user.id)

  rescue ActiveRecord::RecordNotFound # if session[:guest_user_id] invalid
     session[:guest_user_id] = nil
     guest_user if with_retry
  end

  private

  # def store_location
  #   # store last url as long as it isn't a /users path
  #   session[:previous_url] = request.fullpath unless request.fullpath =~ /\/users/
  # end

  # def after_sign_in_path_for(resource)
  #   if session[:previous_url] =~ /\/business_cards/
  #     session[:previous_url] || root_path
  #   else
  #     instructions_path
  #   end
  # end

   # called (once) when the user logs in, insert any code your application needs
  # to hand off from guest_user to current_user.
  def logging_in
    connection = current_user.connections.first
    connection.user_id = current_user.id
    connection.save
  end

  def create_guest_user
    u = User.create(email: "guest_#{Time.now.to_i}#{rand(100)}@example.com", guest: true)
    u.save!(:validate => false)
    session[:guest_user_id] = u.id
    u
  end
end
