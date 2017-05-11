Rails.application.routes.draw do

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
    resources :connection_requests, only: [ :create ]
  end

  #connections
  delete 'business_cards/:business_card_id/destroyconnection', to: 'connections#destroy'

  #communities
  resources :communities

  #conversations
  resources :conversations, only: [:index, :create] do
    resources :messages, only: [:index, :new ]
  end

  post 'conversations/:conversation_id/sendmessage', to: 'conversations#send_message'

  post 'conversations/:conversation_id/readmessages', to: 'conversations#read_messages'


  resources :connection_requests, only: [:update]

  # tags
  post 'business_cards/:id', to: 'business_cards#create_tags'
  delete 'business_cards/:id/deletetag', to: 'business_cards#delete_tag'

  #email signature
  get 'business_cards/:business_card_id/emailconnection', to: 'connections#create'
  post 'business_cards/:business_card_id/connections/guestconnection', to: 'connections#guest_connection', as: :guest_connection

  #join community link
  get 'communities/:id/joincommunity', to: 'communities#join_community'

  # pages
  get 'about', to: 'pages#about'
  get 'terms', to: 'pages#terms'
  get 'instructions', to: 'pages#instructions'
  get 'nlac-logo.png', to: 'pages#image'

  get "/contacts/:importer/callback" => "connections#omnicontacts_index"

end
