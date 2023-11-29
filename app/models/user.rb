# t.string :username
# t.string :email
# t.string :password_digest

class User < ApplicationRecord
    has_one :client, dependent: :destroy
    has_many :user_service_provider_accesses, dependent: :destroy
    has_many :service_providers, through: :user_service_provider_accesses

    has_secure_password

    validates_uniqueness_of :email
end
