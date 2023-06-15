
require 'base64'
require 'httparty'
require 'excon'
require 'json'

class MpesaService
  def initialize(consumer_key, consumer_secret)
    @consumer_key = '9qBCLkcypq5nsN9ceT5WkEWEdgfJffHk'
    @consumer_secret ='a2QfzNF0wsvNgXdA'
  end
  def generate_token
    token = 'Basic ' + base64_encoded(@consumer_key, @consumer_secret)
    url = 'https://sandbox.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials'
    headers = { 'Authorization' => token }
    response = HTTParty.get(url, headers: headers)
    access_token = JSON.parse(response.body)["access_token"]
    access_token
  end
  

  def initiate_stk_push(amount, phone_number, callback_url, account_reference, transaction_desc)
    time = create_timestamp
    password = Base64.strict_encode64("174379" + "bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919" + time)

    body = {
      "BusinessShortCode" => 174379,
      "Password" => password,
      "Timestamp" => time,
      "TransactionType" => "CustomerPayBillOnline",
      "Amount" => amount,
      "PartyA" => phone_number,
      "PartyB" => 174379,
      "PhoneNumber" => phone_number,
      "CallBackURL" => 'https://mydomain.com/path',
      "AccountReference" => 'CompanyXLTD',
      "TransactionDesc" => 'Payment of X'
    }

    headers = {
      "Authorization" => "Bearer " + generate_token,
      "Content-Type" => "application/json"
    }

    response = Excon.post("https://sandbox.safaricom.co.ke/mpesa/stkpush/v1/processrequest", body: JSON.generate(body), headers: headers)
    data = JSON.parse(response.body)
    data
  end

  private

  def base64_encoded(key, secret)
    data = Base64.encode64(key + ':' + secret).gsub(/\n/, '')
    return data
  end

  def create_timestamp
    Time.now.strftime('%Y%m%d%H%M%S')
  end
  

 

    
end


