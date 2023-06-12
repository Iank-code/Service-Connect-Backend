# Rails.application.routes.draw do
  # get 'sessions/login'
  # get 'sessions/signup'
  # resources :bookings
  # resources :reviews
  # resources :microservices
  # resources :services
  # resources :service_providers

   #   resources :admins
#   # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

#   # Defines the root path route ("/")
#   # root "articles#index"
# end
Rails.application.routes.draw do
  # Other routes...
resources :customers
resources :bookings
resources :reviews
resources :microservices
resources :services
resources :service_provider
get '/current_user', to:'application#current_user'
  # Admin routes
  post '/admin/signup', to: 'admin#create_admin'
  post '/admin/login', to: 'admin#login_admin'
  delete '/admin/:admin_id', to: 'admin#delete_admin'

  post '/admin/service', to: 'admin#add_service'
  delete '/admin/service/:service_id', to: 'admin#delete_service'


# Customer routes
  post '/customer/register', to:'customers#register'

  post '/customer/login', to:'customers#login'

  delete '/customer/logout', to:'customers#logout'

  get '/customer/check_login_status', to:'customers#check_login_status'


# Service Provider routes

  post '/service_provider/register', to: 'service_provider#signup'

  post '/service_provider/login', to: 'service_provider#login'

  get '/service_provider/bookings', to:'service_provider#view_bookings'

  post '/login', to: 'sessions#login'

end


