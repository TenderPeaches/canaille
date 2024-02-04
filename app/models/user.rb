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
        user_service_provider_accesses.where(user_role: UserRole.admin)
    end

    def has_service_provider_access?
        user_service_provider_accesses.size > 0
    end

    # return a service provider that this user manages, if any
    # if user has many providers, only returns the first that comes up 
    def service_provider
        if has_service_provider_access?
            user_service_provider_accesses.active.first.service_provider
        else 
            nil
        end
    end

    def is_service_provider_admin?(for_service_provider)
        access = user_service_provider_accesses.where(service_provider: for_service_provider, user_role: UserRole.admin).includes(:user_role)
        
        if access.any?
            return access.first.user_role == UserRole.admin
        end

        return false
    end
end
