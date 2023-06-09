class CustomersController < ApplicationController
  before_action :session_expired?, only: [:check_login_status]

  def index
    user = Customer.all
    render json: user
  end

  def show
    user = Customer.find(params[:id])
    blob = ActiveStorage::Blob.find(params[:id])
    image = url_for(blob)
    app_response(status: :ok, data: {user: user, image: image})
  end

  def register
    user = Customer.create(user_params)
    if user.valid?
      save_user(user.id)
      token = encode(user.id, user.email)
      session[:user_id] = user.id
      blob = ActiveStorage::Blob.find(user.id)
      image = url_for(blob)
      user_attributes = user.attributes.except('updated_at', 'created_at', 'password_digest')

      app_response(message: 'Registration was successful', status: :created, data: {user: user_attributes, token: token, image: image, route: 'http://127.0.0.1:3000/customer/logout'})
    else
      app_response(message: 'Something went wrong during registration', status: :unprocessable_entity, data: user.errors)
    end
  end

        
  
  def login
    sql = "username = :username OR email = :email"
    user = Customer.where(sql, { username: user_params[:username], email: user_params[:email] }).first
    if user&.authenticate(user_params[:password])
      save_user(user.id)
      token = encode(user.id, user.email)
      blob = ActiveStorage::Blob.find(user.id)
      image = url_for(blob)
      user_attributes = user.attributes.except('updated_at', 'created_at', 'password_digest')
      app_response(message: 'Login was successful', status: :ok, data: { user: user_attributes, token: token, image: image, route: 'http://127.0.0.1:3000/customer/logout' })
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

  def update_password
    @user = User.find(id: session[:user_id])
    if @user && @user.authenticate(params[:current_password])
      if @user.update(password:params[:new_password], password_confirmation: params[new_password_confirmation])
        app_response(message: 'Password changed successful', status: :success)
      end
    end
  end
  
  private

  def user_params
    params.permit(:username, :email, :password, :password_confirmation, :role, :address, :phone_number, :file)
  end
  def user_cred
    params.permit(:current_password, :new_password, :new_password_confirmation)
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
    params.permit(:username, :email, :password, :password_confirmation, :address, :phone_number, :role, :file)
  end
end
