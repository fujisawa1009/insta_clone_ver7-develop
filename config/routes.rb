Rails.application.routes.draw do
  root to: 'posts#index'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'user_sessions#new'
  post '/login', to: 'user_sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :posts do
    resources :comments, module: :posts
    resource :like, only: %i[create destroy], module: :posts
  end

  resources :users, only: %i[index show] do
    resource :relationship, only: %i[create destroy], module: :users
  end

  namespace :mypage do
    resource :account, only: %i[edit update]
  end
end