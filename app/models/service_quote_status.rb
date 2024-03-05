# t.string :label
# t.string :description
class ServiceQuoteStatus < ApplicationRecord

    validates :label, uniqueness: true

    def self.open
        ServiceQuoteStatus.where(label: "Open").first
    end

    def self.closed
        ServiceQuoteStatus.where(label: "Closed").first
    end

    def self.cancelled
        ServiceQuoteStatus.where(label: "Cancelled").first
    end

    def self.accepted
        ServiceQuoteStatus.where(label: "Accepted").first
    end
end
