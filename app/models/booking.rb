class Booking < ApplicationRecord
  belongs_to :customer
  belongs_to :service_provider
end
