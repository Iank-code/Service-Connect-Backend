# Rails.application.routes.draw do
  # resources :service_provider_informations
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
  post '/initiate_stk_push', to: 'mpesa#initiate_stk_push'

  mount ActionCable.server => '/cable'

  # Other routes...
  resources :customers
  resources :bookings
  resources :reviews
  resources :microservices
  resources :services
  resources :service_providers
  get '/current_user', to:'application#current_user'
  get '/mpesa/credentials', to:'mpesa#credentials'
  post '/mpesa/payments', to:'mpesa#create'

  # Admin routes
  post '/admin/signup', to: 'admin#create_admin'
  post '/admin/login', to: 'admin#login_admin'
  delete '/admin/:admin_id', to: 'admin#delete_admin'

  post '/admin/service', to: 'admin#add_service'
  delete '/admin/service/:service_id', to: 'admin#delete_service'


  # Customer routes
  post '/customer/register', to:'customers#register'

  get '/customer/:id', to: 'customers#show'

  post '/customer/login', to:'customers#login'

  delete '/customer/logout', to:'customers#logout'

  get '/customer/check_login_status', to:'customers#check_login_status'

  patch '/update/password', to: "customers#update_password"


  # Service Provider routes

  post '/service_provider/register', to: 'service_providers#register'
  get '/service_provider', to: 'service_providers#index'
  get '/service_provider/:id', to: 'service_providers#show'
  delete '/service_provider/logout', to: 'service_providers#logout'

  post '/service_provider/login', to: 'service_providers#login'

  get '/service_provider/bookings', to:'service_provider#view_bookings'

  post '/login', to: 'sessions#login'

end


