class Client < ApplicationRecord
    belongs_to :user
    has_many :service_requests
    has_many :service_quotes, through: :service_requests
    belongs_to :coordinate, optional: true
end
