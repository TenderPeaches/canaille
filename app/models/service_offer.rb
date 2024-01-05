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

    validates :min_price, comparison: { greater_than_or_equal_to: 0, less_than_or_equal_to: max_price }
    validates :max_price, comparison: { greater_than_or_equal_to: min_price }
end
