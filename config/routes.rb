Rails.application.routes.draw do
  resources :bookings
  resources :reviews
  resources :microservices
  resources :services
  resources :service_providers
  resources :customers
  resources :admins
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
