class Service < ApplicationRecord
  belongs_to :service_provider
  has_many :microservices
  has_many_attached :images

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: {greater_than_or_equalto: 0 }
  # validates :service_provider_id, presence: true
end
