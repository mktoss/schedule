Rails.application.routes.draw do
  devise_for :users

  root 'events#index'

  get 'application/home'

  resources :events, only: [:index]
end
