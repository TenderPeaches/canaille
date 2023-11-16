class UserRole < ApplicationRecord
    has_many :user_service_provider_accesses
end
