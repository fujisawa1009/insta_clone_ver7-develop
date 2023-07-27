Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get '/health_check', to: 'health_checks#show'
  root to: 'samples#index'
end
