class User < ApplicationRecord
    has_one :user
    has_many :user_service_provider_accesses
    has_many :service_providers, through: :user_service_provider_accesses

    has_secure_password

    validates_uniqueness_of :email
end
