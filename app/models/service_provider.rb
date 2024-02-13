# t.string :name
# t.string :description
# t.string :schedule
# t.string :phone_number
# t.string :email_address
# t.references :coordinate, null: true, foreign_key: true
class ServiceProvider < ApplicationRecord
    has_many :user_service_provider_accesses
    has_many :users, through: :user_service_provider_accesses
    has_many :service_offers
    has_many :services, through: :service_offers
    has_many :service_quotes
    has_many :service_requests, through: :service_quotes
    belongs_to :coordinate, optional: true

    accepts_nested_attributes_for :coordinate
    
    before_save :destroy_coordinate_if_empty

    def destroy_coordinate_if_empty
        if coordinate && coordinate.empty?
            old_coord = coordinate
            self.coordinate_id = nil
            begin
                old_coord.destroy
            rescue ActiveRecord::InvalidForeignKey
                #todo if coordinate has other objects tied to it somehow, their coordinate_id should also be set to nil, but it's edge case with super low priority that has marginal benefits so wtv
            end
        end 
    end

    def active_quotes
        service_quotes.where(status: ServiceQuoteStatus.open)
    end

    def active_accesses
        # accesses are active until they're not - if an "inactive_from" time is specified, access is assumed to be revoked (or role changed)
        user_service_provider_accesses.where(inactive_from: nil)
    end

    def quote_history
        # reverse chronological order
        service_quotes.order(created_at: :desc)
    end
end
