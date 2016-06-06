Rails.application.routes.draw do
  resources :home, only: [:index]
  root 'home#index'

  post 'default' => 'home#default'
  post 'search' => 'home#search'

  get 'preferences' => 'members#preferences', as: 'preferences'

end
