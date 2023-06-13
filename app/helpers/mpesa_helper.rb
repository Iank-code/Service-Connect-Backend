require 'oauth2'

module MpesaHelper
  def get_access_token
    client = OAuth2::Client.new(
      ENV['MPESA_CONSUMER_KEY'],
      ENV['MPESA_CONSUMER_SECRET'],
      site: 'https://sandbox.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials' # Replace with the appropriate OAuth API endpoint URL
    )

    token = client.client_credentials.get_token
    access_token = token.token

    access_token # Return the access token
  end
end
