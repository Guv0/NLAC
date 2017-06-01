class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :unread_messages
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

   # called (once) when the user logs in, insert any code your application needs
  # to hand off from guest_user to current_user.
  def logging_in
    connection = guest_user.connections.first
    connection.user_id = current_user.id
    connection.save
  end

  def create_guest_user
    u = User.create(email: "guest_#{Time.now.to_i}#{rand(100)}@example.com", guest: true)
    u.save!(:validate => false)
    session[:guest_user_id] = u.id
    u
  end

  def unread_messages
    if current_user
      conversations = Conversation.where('sender_id = ? OR recipient_id = ?', current_user.id, current_user.id)
      received_messages = []
      conversations.each do |conversation|
        received_messages << conversation.messages.where.not(user_id: current_user.id)
      end
      unread_messages_count = 0
      received_messages.flatten.each do |message|
        unread_messages_count += 1 if message.read == false
      end
      @unread_messages_count = unread_messages_count
    end
  end

  def requests
  end
end
