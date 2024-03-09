# t.string :label
# t.string :description
# t.references :service_category, null: true, foreign_key: true
#
# t.timestamps

class Service < ApplicationRecord
    belongs_to :service_category
    belongs_to :service_status
    has_many :service_requests
    has_many :service_offers
    has_many :service_quotes, through: :service_requests

    validates :name, uniqueness: true

    scope :active, -> { where(service_status: ServiceStatus.active) }

    def self.unknown
        Service.find_by_name("Unknown") || Service.first
    end
end
