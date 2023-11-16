class ServiceOffer < ApplicationRecord
    belongs_to :service
    belongs_to :service_provider 
end
