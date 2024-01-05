Rails.application.routes.draw do
  root 'home#index'

  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]
  resources :posts, only: [:index]

  namespace :api do
    namespace :v1 do
      post '/login', to: 'sessions#create'
      post 'register', to: 'users#create'
      get 'login', to: 'sessions#new'
      get 'register', to: 'users#new'
      get  'posts', to: 'posts#index'
      delete '/logout', to: 'sessions#destroy'
    end
  end
end


