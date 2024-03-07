# t.references :user, null: false, foreign_key: true
# t.references :coordinate, null: true, foreign_key: true
# t.string :phone_number
class Client < ApplicationRecord
    belongs_to :user
    has_many :service_requests
    has_many :service_quotes, through: :service_requests, dependent: :destroy
    belongs_to :coordinate, optional: true

    accepts_nested_attributes_for :coordinate, allow_destroy: true

    #! business logic
    def active_service_requests
        service_requests.where(service_request_status_id: ServiceRequestStatus.actives)
    end
end
