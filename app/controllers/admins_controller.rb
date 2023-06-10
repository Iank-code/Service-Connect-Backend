class AdminController < ApplicationController
    before_action :verify_auth


    before_action :session_expired?, only: [:check_login_status]

    def register
        user = User.create(user_params)
        if user.valid?
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

  def delete_admin
    # Check if the user is authenticated and is an admin
    if current_user && current_user.admin?
      # Retrieve the admin
      admin = User.find(params[:admin_id])

      # Delete the admin
      admin.destroy

      # Return a success response
      render plain: "Admin deleted successfully."
    else
      # Return an unauthorized error response
      render plain: "Unauthorized.", status: 401
    end
  end

  def add_service
    # Check if the user is authenticated and is an admin
    if current_user && current_user.admin?
      # Retrieve the data from the request
      service_name = params[:service_name]
      service_description = params[:service_description]
      price = params[:price]
      images = params[:images]

      # Create a new service
      service = Service.create(
        service_name: service_name,
        service_description: service_description,
        price: price
      )

      # Attach the images to the service (assuming there is an Image model with a service_id foreign key)
      images.each do |image|
        service.images.attach(image)
      end

      # Return a success response
      render plain: "Service added successfully."
    else
      # Return an unauthorized error response
      render plain: "Unauthorized.", status: 401
    end
  end

  def delete_service
    # Check if the user is authenticated and is an admin
    if current_user && current_user.admin?
      begin
        # Retrieve the service
        service = Service.find(params[:service_id])
        # Delete the service
        service.destroy
        # Return a success response
        render plain: "Service deleted successfully."
      rescue ActiveRecord::RecordNotFound
        # Return a not found error response
        render plain: "Service not found.", status: 404
      end
    else
      # Return an unauthorized error response
      render plain: "Unauthorized.", status: 401
    end
  end

  private

  def user_params
    params.permit(:username, :email, :password)
end
end
