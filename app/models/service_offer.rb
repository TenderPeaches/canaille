# t.references :service, null: false, foreign_key: true
# t.references :service_provider, null: false, foreign_key: true
#
# t.string :description
#
# t.decimal :min_price
# t.decimal :max_price
class ServiceOffer < ApplicationRecord
    belongs_to :service
    belongs_to :service_provider 
end
