# t.references :user, null: false, foreign_key: true
# t.references :coordinate, null: true, foreign_key: true
# t.string :phone_number
# t.string :email_address
class Client < ApplicationRecord
    belongs_to :user
    has_many :service_requests
    has_many :service_quotes, through: :service_requests
    belongs_to :coordinate, optional: true

    def active_service_requests
        service_requests
    end
end
