Rails.application.routes.draw do
  resources :home, only: [:index]
  root 'home#index'

  post 'default' => 'home#default'
  post 'search' => 'searches#create'
  get 'preferences' => 'members#preferences', as: 'preferences'
  post 'create' => 'blacklists#create'
end
