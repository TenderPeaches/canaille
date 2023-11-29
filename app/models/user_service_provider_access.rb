# t.references :user
# t.references :service_provider
# t.references :user_role
# t.references :grantor, class_name: "User"

class UserServiceProviderAccess < ApplicationRecord
    belongs_to :user
    belongs_to :service_provider
    belongs_to :user_role
    belongs_to :grantor, class_name: "User", optional: true
end
