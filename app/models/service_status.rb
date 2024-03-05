class ServiceStatus < ApplicationRecord
    has_many :services

    scope :active, -> { where(label: "Active").first }
    scope :pending, -> { where(label: "Pending").first }
    scope :inactive, -> { where(label: "Inactive").first }

    #! rearrange migrations, otherwise just pencil in the ID for pending status
    def self.default_id
        # services must be approved before being officially used, but they can still be assigned to service_requests
        2
    end
end
