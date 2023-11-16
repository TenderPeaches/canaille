class ServiceQuote < ApplicationRecord
    belongs_to :service_request
    belongs_to :user
    belongs_to :status, class_name: "ServiceQuoteStatus"
end
