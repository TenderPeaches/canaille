# t.references :service_request, null: false, foreign_key: true
# t.references :user, null: false, foreign_key: true
# t.references :status, class_name: "ServiceQuoteStatus", null: false, foreign_key: true
#
# t.decimal :price
# t.string :notes
class ServiceQuote < ApplicationRecord
    belongs_to :service_request
    belongs_to :service_provider
    belongs_to :user
    belongs_to :status, class_name: "ServiceQuoteStatus"
end
