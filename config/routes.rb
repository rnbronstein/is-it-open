Rails.application.routes.draw do
  resources :home, only: [:index]
  root 'home#index'

  post 'search' => 'home#search'
  get 'preferences' => 'members#preferences', as: 'preferences'

end
