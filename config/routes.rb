Rails.application.routes.draw do

  get 'community_requests/index'

  get 'community_requests/create'

  get 'community_requests/update'

  get 'community_requests/destroy'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  # root
  root to: 'connections#root'

  # users
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks', sessions: "sessions", registrations: "registrations" }

  # business_cards
  resources :business_cards, only: [ :show, :edit, :update ] do
    # connections
    resources :connections, only: [ :index, :create ]
    # connection_requests
    resources :connection_requests, only: [ :index, :create, :update, :destroy ]
  end

  # tags
  post 'business_cards/:id', to: 'business_cards#create_tags'
  delete 'business_cards/:id/deletetag', to: 'business_cards#delete_tag'


  #communities
  resources :communities do
    # community_requests
    resources :community_requests, only: [ :create, :update, :destroy ]
  end

  #my communities
  get 'mycommunities', to: 'communities#my_communities', as: 'my_communities'

  #join community link
  get 'communities/:id/joincommunity', to: 'communities#join_community', as: 'join_community'

  #leave community
  get 'communities/:id/leavecommunity', to: 'communities#leave_community', as: 'leave_community'

  #post message
  post 'communities/:id/postmessage', to: 'communities#post_message', as: 'community_community_messages'


  #conversations
  resources :conversations, only: [:index, :create] do
    resources :messages, only: [:index, :new ]
  end

  post 'conversations/:conversation_id/sendmessage', to: 'conversations#send_message'

  post 'conversations/:conversation_id/readmessages', to: 'conversations#read_messages'

  #destroy connection
  resources :connections, only: [ :destroy ]


  #email signature
  get 'business_cards/:business_card_id/emailconnection', to: 'connections#create'
  post 'business_cards/:business_card_id/connections/guestconnection', to: 'connections#guest_connection', as: :guest_connection


  # pages
  get 'about', to: 'pages#about'
  get 'terms', to: 'pages#terms'
  get 'instructions', to: 'pages#instructions'
  get 'nlac-logo.png', to: 'pages#image'

  get "/contacts/:importer/callback" => "connections#omnicontacts_index"

end
