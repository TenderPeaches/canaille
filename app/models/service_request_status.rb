# t.label
# t.description
class ServiceRequestStatus < ApplicationRecord
    has_many :service_requests

    validates :label, uniqueness: true

    def self.default
        ServiceRequestStatus.first # refer to the seed file, whichever service request status is first declare will be default
    end

    def self.created
        ServiceRequestStatus.where(label: "Created").first
    end

    def self.posted
        ServiceRequestStatus.where(label: "Posted").first
    end

    def self.cancelled
        ServiceRequestStatus.where(label: "Cancelled").first
    end

    def self.accepted
        ServiceRequestStatus.where(label: "Quote Accepted").first
    end

    def self.closed
        ServiceRequestStatus.where(label: "Closed").first
    end

    def self.actives
        [self.posted, self.accepted]
    end

end
