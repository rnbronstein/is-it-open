Rails.application.routes.draw do
  resources :home, only: [:index]
  root 'home#index'

  post 'default' => 'home#default'
  post 'search' => 'search#create'
  get 'preferences' => 'members#preferences', as: 'preferences'

end
