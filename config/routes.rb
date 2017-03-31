Rails.application.routes.draw do

  # root
  root to: 'connections#root'

  # users
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  # business_cards
  resources :business_cards, only: [ :show, :edit, :update, :destroy ] do
    # connections
    resources :connections, only: [ :index, :create ]
  end

  # tags
  post 'business_cards/:id', to: 'business_cards#create_tags'

  # pages
  get 'about', to: 'pages#about'
  get 'terms', to: 'pages#terms'
  get 'instructions', to: 'pages#instructions'
  get 'nlac-logo.png', to: 'pages#image'

end
