# t.references :user
# t.references :service_provider
# t.references :user_role
# t.references :grantor, class_name: "User"
# t.datetime :active_from
# t.datetime :inactive_from

class UserServiceProviderAccess < ApplicationRecord
    belongs_to :user
    belongs_to :service_provider
    belongs_to :user_role
    belongs_to :grantor, class_name: "User", optional: true

    scope :active, -> { where(inactive_from: nil) }

    before_validation :set_active_from
    
    # set :active_from to now if it hasn't been explicitly set
    def set_active_from 
        if active_from.nil? || active_from.blank?
            self.active_from = Time.now
        end
    end

    def active?
        inactive_from.nil?
    end
end
