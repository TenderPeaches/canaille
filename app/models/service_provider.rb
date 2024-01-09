# t.string :name
# t.string :description
# t.string :schedule
# t.string :phone_number
# t.string :email_address
# t.references :coordinate, null: true, foreign_key: true
class ServiceProvider < ApplicationRecord
    has_many :user_service_provider_accesses
    has_many :users, through: :user_service_provider_accesses
    has_many :service_offers
    has_many :services, through: :service_offers
    has_many :service_quotes
    has_many :service_requests, through: :service_quotes
    belongs_to :coordinate, optional: true

    accepts_nested_attributes_for :coordinate
end
