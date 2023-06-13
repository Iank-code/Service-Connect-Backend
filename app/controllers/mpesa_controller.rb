class MpesaController < ApplicationController
    include MpesaHelper
    def credentials
      @consumer_key = ENV['MPESA_CONSUMER_KEY']
      @consumer_secret = ENV['MPESA_CONSUMER_SECRET']
    end
    def create
        # Retrieve the necessary parameters from the request
        phone_number = params[:phone_number]
        amount = params[:amount]
      
        # Use the M-Pesa API credentials and parameters to initiate the payment process
        # Make an HTTP request to the M-Pesa API with the required payload
      
        # Example code using the 'httparty' gem for making HTTP requests
        response = HTTParty.post(
          'https://sandbox.safaricom.co.ke/mpesa/stkpush/v1/processrequest',
          headers: {
            'Content-Type' => 'application/json',
            'Authorization' => "Bearer #{ENV['MPESA_API_TOKEN']}"
          },
          body: {
            phone_number: phone_number,
            amount: amount
          }.to_json
        )
      
        # Handle the response from the M-Pesa API
        if response.success?
          # Payment successful
          render json: { status: 'success', message: 'Payment completed successfully' }
        else
          # Payment failed
          render json: { status: 'error', message: 'Payment failed' }, status: :unprocessable_entity
        end
    end
      
end
  