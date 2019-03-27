Rails.application.routes.draw do
  devise_for :users

  root 'users#show'

  resource  :users,  only: [:show]
  resources :events, only: [:index]
end
