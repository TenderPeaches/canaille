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
end
