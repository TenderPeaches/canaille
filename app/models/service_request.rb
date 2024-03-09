# t.references :service, null: false, foreign_key: true
# t.references :client, null: false, foreign_key: true
# t.references :coordinate, null: true, foreign_key: true
#
# t.string :notes
# t.decimal :min_price
# t.decimal :max_price
#
# t.timestamps

class ServiceRequest < ApplicationRecord
    belongs_to :service
    belongs_to :client
    belongs_to :coordinate, optional: true
    belongs_to :service_request_status
    has_many :service_quotes

    accepts_nested_attributes_for :coordinate
    accepts_nested_attributes_for :client
    accepts_nested_attributes_for :service, reject_if: :all_blank

    validates :min_price, comparison: { greater_than_or_equal_to: 0, less_than_or_equal_to: :max_price }, unless: -> { min_price.blank? }
    validates :max_price, comparison: { greater_than_or_equal_to: :min_price }, unless: -> { max_price.blank? }

    def used_coordinate
        if coordinate
            coordinate
        elsif client
            client.coordinate
        else
            Coordinate.none
        end
    end

    def status
        service_request_status&.label.downcase.to_sym
    end

    def quotes
        service_quotes.where(status: [ServiceQuoteStatus.open, ServiceQuoteStatus.closed])
    end

    def cancellable
        [ServiceRequestStatus.created, ServiceRequestStatus.posted, ServiceRequestStatus.accepted].include? service_request_status
    end

    def activable
        service_request_status == ServiceRequestStatus.cancelled
    end

    #! business logic
    def active?
        ServiceRequestStatus.actives.include? service_request_status
    end

    # returns a list of service providers who could fulfill this request, depending on the client's preferences
    def find_service_offers
        #! need to add geography-related factors, so closer service providers show up first
        ServiceOffer.where(service_id: service_id).includes(:service_provider)
    end
end
