# t.string :username
# t.string :email
# + devise stuff 

class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
    has_one :client, dependent: :destroy
    has_many :user_service_provider_accesses, dependent: :destroy, inverse_of: :user
    has_many :access_grants, class_name: "UserServiceProviderAccess", inverse_of: :grantor
    has_many :service_providers, through: :user_service_provider_accesses

    attr_accessor :is_client, :is_service_provider

    validates_uniqueness_of :email

    def admin_service_provider_accesses
        user_service_provider_accesses.where(user_role: UserRole.find_by_name('Admin'))
    end

    def has_service_provider_access?
        user_service_provider_accesses.size > 0
    end
end
