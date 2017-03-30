Rails.application.routes.draw do

  post 'business_cards/:id', to: 'business_cards#create_tags'

  # root
  root to: 'connections#root'

  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  # business_cards
  resources :business_cards, only: [ :show, :edit, :update, :destroy ] do
    resources :connections, only: [ :index ]
  end

  # pages
  get 'about', to: 'pages#about'
  get 'terms', to: 'pages#terms'
  get 'instructions', to: 'pages#instructions'
  get 'nlac-logo.png', to: 'pages#image'

end
