class UserServiceProviderAccessesController < ApplicationController
    before_action :authorize, only: %i[ index ]
    
    def index
        @accesses = current_user.user_service_provider_accesses.active
    end 

    def new
        set_service_provider
        @user_service_provider_access = UserServiceProviderAccess.new(grantor_id: current_user.id, service_provider_id: @service_provider)
    end 
    
    def edit
        set_user_service_provider_access
    end

    def create
        set_service_provider
        assess_user

        @user_service_provider_access = UserServiceProviderAccess.new(user_service_provider_access_params)

        unless @user_service_provider_access.save
            flash.alert = @user_service_provider_access.errors.full_messages
        end
    end 

    def update
        set_user_service_provider_access
        @user_service_provider_access.update
    end

    def destroy
        set_user_service_provider_access
        @user_service_provider_access.destroy
    end

    private
    def set_service_provider
        @service_provider = ServiceProvider.find_by_id(params(:service_provider_id))
    end 

    def set_user_service_provider_access
        @user_service_provider_access = UserServiceProviderAccess.find_by_id(params(:id))
    end

    def assess_user
        potential_users = User.find_by_username(user_service_provider_access_params(:user))
    end

    def user_service_provider_access_params
        params.require(:user_service_provider_access).permit(:user_id, :user, :grantor_id, :service_provider_id, :user_role_id)
    end
end
