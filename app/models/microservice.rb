class Microservice < ApplicationRecord
  belongs_to :service
  has_many_attached :images
end
