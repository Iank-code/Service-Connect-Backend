class CustomersController < ApplicationController
    before_action :session_expired?, only: [:check_login_status]
  
    def register
      user = User.new(user_params)
      if user.save
        save_user(user.id)
        app_response(message: 'Registration was successful', status: :created, data: user)
      else
        app_response(message: 'Something went wrong during registration', status: :unprocessable_entity, data: user.errors)
      end
    end
  
        
  
    def login
      sql = "username = :username OR email = :email"
      user = User.where(sql, { username: user_params[:username], email: user_params[:email] }).first
      if user&.authenticate(user_params[:password])
        save_user(user.id)
        token = encode(user.id, user.email)
        app_response(message: 'Login was successful', status: :ok, data: { user: user, token: token })
      else
        app_response(message: 'Invalid username/email or password', status: :unauthorized)
      end
    end
  
    def logout
      remove_user
      app_response(message: 'Logout successful')
    end
  
    def check_login_status
      app_response(message: 'Success', status: :ok)
    end
  
    private
  
    def user_params
      params.require(:customer).permit(:username, :email, :password, :address, :phone_number)
    end
  end
  