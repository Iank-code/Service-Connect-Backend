class CustomerMailer < ApplicationMailer
    # default from: 'mailertest254@gmail.com'
    default from: 'kian99564@gmail.com'

    def welcome_email(user)
        @user = user
        # @url  = 'http://localhost:3000/customer/register'
        mail(to: @user.email, subject: 'Welcome to My Awesome Site',body: 'Lorem Ipsum notifications')
    end
end
