# t.string :name
# t.string :description
class UserRole < ApplicationRecord
    has_many :user_service_provider_accesses

    validates :name, uniqueness: true
end
