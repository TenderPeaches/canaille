# t.references :service, null: false, foreign_key: true
# t.references :service_provider, null: false, foreign_key: true
#
# t.string :description
#
# t.decimal :min_price
class ServiceOffer < ApplicationRecord

    
    belongs_to :service
    belongs_to :service_provider 

    validates :min_price, numericality: { allow_nil: true, greater_than_or_equal_to: 0 }
end
