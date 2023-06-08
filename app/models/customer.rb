class Customer < ApplicationRecord
    has_one_attached :image
    has_many :bookings
end
