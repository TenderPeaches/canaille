# t.label
# t.description
class ServiceRequestStatus < ApplicationRecord
    has_many :service_requests

    validates :label, :uniqueness: true

    def self.default
        ServiceRequestStatus.first # refer to the seed file, whichever service request status is first declare will be default
    end
end
