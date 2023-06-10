class ServiceProvidersController < ApplicationController
    before_action :session_expired?, only: [:check_login_status]

    def register
        user = ServiceProvider.create(user_params)
        if user.valid?
            save_user(user.id)
            app_response(message: 'Registration was successful', status: :created, data: user)
        else
            app_response(message: 'Something went wrong during registration', status: :unprocessable_entity, data: user.errors)
        end
    end
        
    def login
        sql = "username = :username OR email = :email"
        user = ServiceProvider.where(sql, { username: user_params[:username], email: user_params[:email] }).first
        if user&.authenticate(user_params[:password])
            save_user(user.id)
            token = encode(user.id, user.email)
            app_response(message: 'Login was successful', status: :ok, data: {user: user, token: token})
        else
            app_response(message: 'Invalid username/email or password', status: :unauthorized)
        end
    end
      

    def logout
        remove_user
        app_response(message: 'Logout successful')
    end

    def check_login_status
        app_response(message: 'success', status: :ok)
    end


    def logout
        remove_user
        app_response(message: 'Logout successful')
    end

    def check_login_status
        app_response(message: 'success', status: :ok)
    end
        def view_bookings
          # Check if the user is authenticated and is a service provider
          if current_user && current_user.is_a?(ServiceProvider)
            # Retrieve the bookings from the Booking table for the service provider
            bookings = Booking.where(provider_id: current_user.id)
      
            # Return the bookings in the response
            render json: bookings
          else
            # Return an unauthorized error response
            render plain: "Unauthorized.", status: 401
          end
        end
      
        private 
    
        def user_params
            params.permit(:username, :email, :password, :profile_image, :location, :phone_number, :experience, :summary, :work_image, :availability)
        end
       
      
end
