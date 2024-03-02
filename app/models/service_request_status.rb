# t.label
# t.description
class ServiceRequestStatus < ApplicationRecord
    has_many :service_requests

    validates :label, uniqueness: true

    def self.default
        if Rails.env.production?
            ServiceRequestStatus.first # refer to the seed file, whichever service request status is first declare will be default
        # mainly for test environment, instead of using factories to create them when needed
        else
            ServiceRequestStatus.first || ServiceRequestStatus.new(label: "Test Status")
        end
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
