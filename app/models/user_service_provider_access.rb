class UserServiceProviderAccess < ApplicationRecord
    belongs_to :user
    belongs_to :service_provider
    belongs_to :user_role
end
