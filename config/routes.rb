Rails.application.routes.draw do
  # get 'blogs/new'
  # get 'blogs/create'
  # get 'blogs/edit'
  # get 'blogs/update'
  # get 'blogs/show'
  # get 'blogs/index'
  # root 'home#index'

  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]
  resources :blogs
  resources :posts, only: [:index]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  root 'blogs#index'

  # namespace :api do
  #   namespace :v1 do
  #     post '/login', to: 'sessions#create'
  #     post 'register', to: 'users#create'
  #     get 'login', to: 'sessions#new'
  #     get 'register', to: 'users#new'
  #     get  'posts', to: 'posts#index'
  #     delete '/logout', to: 'sessions#destroy'
  #   end
  # end
end


