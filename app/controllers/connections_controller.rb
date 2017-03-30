class ConnectionsController < ApplicationController

def index
end

def root
  redirect_to business_card_connections_path(current_user)
end

end
