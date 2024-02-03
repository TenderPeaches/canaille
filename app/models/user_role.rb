# t.string :name
# t.string :description
class UserRole < ApplicationRecord
    has_many :user_service_provider_accesses

    validates :name, uniqueness: true

    def self.admin
        UserRole.find_by_name('Admin') || UserRole.find_by_name(:admin)
    end

    def self.employee
        UserRole.find_by_name('Employee')
    end
end
