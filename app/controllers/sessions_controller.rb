class SessionsController < ApplicationController
 
def login
   # Retrieve user input from the request parameters
  email = params[:email]password = params[:password]
  
 # Validate user input
  if
   email.blank? || password.blank?
    render json:{ error: "Email and password are required"}, status:: unprocessable_entity
  
      return
  
      
  end
  
  
      
  # Authenticate the user (you can use your own authentication logic here)
  
      user = User.find_by(email:email)
       if
        user.nil ? || !user.authenticate(password)
        render json:{ error:"Invalid email or password"}, status::unauthorized
  
        return
  
      end
  
  
      
  # Generate a JWT token for the authenticated user
  
      token = JWT.encode({ user_id:user.id }, Rails.application.secrets.secret_key_base)
  
      
  # Return the JWT token in the response
  
      render json:{ token:token }
    
  end
  
  end

  def signup
  end
end
