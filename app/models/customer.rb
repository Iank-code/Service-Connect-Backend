class Customer < ApplicationRecord
    has_secure_password
    has_many :bookings
    has_one_attached :file

    validates :file, presence: true
    validates :email, {
        presence: true,
        uniqueness: true
    }
end
