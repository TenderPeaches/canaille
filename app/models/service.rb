class Service < ApplicationRecord
    belongs_to :service_category
    has_many :service_requests
    has_many :service_offers
    has_many :service_quotes, through: :service_requests
end
