# app/controllers/some_controller.rb

class SomeController < ApplicationController
    def some_action
        consumer_key = '9qBCLkcypq5nsN9ceT5WkEWEdgfJffHk'
        consumer_secret ='a2QfzNF0wsvNgXd'
  
      mpesa_service = MpesaService.new(consumer_key, consumer_secret)
      data = mpesa_service.initiate_stk_push(1, '254701895244', 'https://mydomain.com/path', 'BusinessName', 'Payment of X')
  
      # Process the response data as needed
      render json: data
    end
  end
  