# t.string :label
# t.string :description
# t.references :service_category, null: true, foreign_key: true
#
# t.timestamps

class Service < ApplicationRecord
    belongs_to :service_category
    has_many :service_requests
    has_many :service_offers
    has_many :service_quotes, through: :service_requests
end
