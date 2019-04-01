Rails.application.routes.draw do
  devise_for :users

  root 'projects#index'

  resources :users, only: [:index]

  resources :projects, except: :show do
    resources :events, except: [:new, :edit]
    resource :todos, only: [:edit, :update] do
      collection do
        get :executed
      end
    end
  end
end
