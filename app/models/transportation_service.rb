class TransportationService < ApplicationRecord
    belongs_to :service
    belongs_to :departure_city, class_name: "City"
    belongs_to :arrival_city, class_name: "City"
end
