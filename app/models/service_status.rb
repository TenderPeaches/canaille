class ServiceStatus < ApplicationRecord
    has_many :services

    #! rearrange migrations, otherwise just pencil in the ID for pending status
    def self.default_id
        # services must be approved before being officially used, but they can still be assigned to service_requests
        2
    end

    def self.default
        self.pending || ServiceStatus.first
    end

    def self.active
        ServiceStatus.find_by_label("Active")
    end

    def self.pending
        ServiceStatus.find_by_label("Pending")
    end

    def self.inactive
        ServiceStatus.find_by_label("Inactive")
    end

end
