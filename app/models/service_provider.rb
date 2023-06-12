class ServiceProvider < ApplicationRecord
    has_secure_password
    has_one_attached :file
    has_one :service_provider_information
    has_many :bookings

    validates :file, presence: true
    validates :email, {
        presence: true,
        uniqueness: true
    }
end
