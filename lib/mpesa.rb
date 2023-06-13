
require 'oauth'
require 'httparty'

class Mpesa
  include HTTParty
  base_uri 'https://sandbox.safaricom.co.ke'
  headers 'Content-Type' => 'application/json'
  headers 'Accept' => 'application/json'

  def initialize(consumer_key, consumer_secret)
    @consumer_key = consumer_key
    @consumer_secret = consumer_secret
    @access_token = authenticate
  end

  def authenticate
    # Generate OAuth access token using consumer key and secret
    response = self.class.post('/oauth/v1/generate?grant_type=client_credentials',
                               basic_auth: { username: @consumer_key, password: @consumer_secret })
    access_token = response['access_token']
    raise 'Failed to authenticate' unless access_token

    access_token
  end

  def lipa_na_mpesa(amount, phone_number)
    # Perform Lipa Na M-Pesa operation
    payload = {
      BusinessShortCode: 'YOUR_BUSINESS_SHORTCODE',
      Password: 'YOUR_PASSWORD',
      Timestamp: Time.now.strftime('%Y%m%d%H%M%S'),
      TransactionType: 'CustomerPayBillOnline',
      Amount: amount,
      PartyA: phone_number,
      PartyB: 'YOUR_BUSINESS_SHORTCODE',
      PhoneNumber: phone_number,
      CallBackURL: 'YOUR_CALLBACK_URL',
      AccountReference: 'YOUR_ACCOUNT_REFERENCE',
      TransactionDesc: 'YOUR_TRANSACTION_DESCRIPTION'
    }

    response = self.class.post('/mpesa/stkpush/v1/processrequest',
                               headers: { 'Authorization' => "Bearer #{@access_token}" },
                               body: payload.to_json)

    # Handle the response and return the result
    if response['ResponseCode'] == '0'
      # Success
      result = response['MerchantRequestID']
    else
      # Error
      result = response['errorMessage']
    end

    result
  end
end
