class UserServiceProviderAccessesController < ApplicationController
    before_action :authorize, only: %i[ index ]
    
    def index
        @accesses = current_user.user_service_provider_accesses.active
    end 

    def new
    end 

    def create
    end 
    
    def edit
    end

    def update
    end

    def destroy
    end
end
