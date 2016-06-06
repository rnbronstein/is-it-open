Rails.application.routes.draw do
  resources :home, only: [:index]
  root 'home#index'

  post 'default' => 'home#default'
  post 'search' => 'search#create'
  get 'preferences' => 'member#preferences', as: 'preferences'
  post 'create' => 'blacklist#create'
end
