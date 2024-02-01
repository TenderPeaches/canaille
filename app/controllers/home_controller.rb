class HomeController < ApplicationController
    def index
        if user_signed_in?
            @user = current_user
            # if user is registered to both request services and offer them
            if current_user.client && current_user.has_service_provider_access?
                # give them a choice 
                render "home/user_menu"
            # otherwise if user is only registered as client
            elsif current_user.client
                render "clients/portal"
            #! shouldn't be a final route, just here to debug
            elsif current_user.client.nil?
                render "home/index"
            # otherwise, user is not a client, only a service_provider
            else
                render "service_providers/portal"
            end
        else
            render "home/index"
        end
    end
end
