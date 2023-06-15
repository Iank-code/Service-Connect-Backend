# app/helpers/mpesa_helper.rb

module MpesaHelper
  def create_timestamp
    year = Time.now
    date = year.to_s.split(' ')[0].split('-').join('')
    date_two = year.to_s.split(' ')[1].split(':').join('')
    "#{date}#{date_two}"
  end
end
