class Service < ApplicationRecord
  belongs_to :service_provider
  has_many_attached :images
end
