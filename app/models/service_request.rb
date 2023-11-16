class ServiceRequest < ApplicationRecord
    belongs_to :service
    belongs_to :client
    belongs_to :coordinate, optional: true
end
