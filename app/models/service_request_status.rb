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
        ServiceRequestStatus.find_by_label("Created")
    end

    def self.posted
        ServiceRequestStatus.find_by_label("Posted")
    end

    def self.cancelled
        ServiceRequestStatus.find_by_label("Cancelled")
    end

    def self.accepted
        ServiceRequestStatus.find_by_label("Quote Accepted")
    end

    def self.closed
        ServiceRequestStatus.find_by_label("Closed")
    end

    def self.actives
        # use nil-safe because test factories might not have all status instanciated
        [self.posted&.id, self.accepted&.id]
    end

end
