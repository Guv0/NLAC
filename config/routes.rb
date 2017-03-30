Rails.application.routes.draw do

  root to: 'pages#home'

  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :business_cards, only: [ :show, :edit, :update, :destroy ]

  get 'instructions', to: 'pages#instructions'
  get 'nlac-logo.png', to: 'pages#image'

end
