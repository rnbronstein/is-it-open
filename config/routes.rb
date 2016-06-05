Rails.application.routes.draw do
  resources :home, only: [:index]
  root 'home#index'

  get 'preferences' => 'members#preferences', as: 'preferences'

end
