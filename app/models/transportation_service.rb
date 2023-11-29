# t.references :departure_city, class_name: "City", null: false, foreign_key: true
# t.references :arrival_city, class_name: "City", null: false, foreign_key: true
# t.references :service, class_name: "City", null: false, foreign_key: true
# t.datetime :departure_time
# t.datetime :arrival_time

class TransportationService < ApplicationRecord
    belongs_to :service
    belongs_to :departure_city, class_name: "City"
    belongs_to :arrival_city, class_name: "City"
end
