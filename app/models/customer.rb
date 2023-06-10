class Customer < ApplicationRecord
    has_secure_password
    has_one_attached :image
    has_many :bookings
 
end
