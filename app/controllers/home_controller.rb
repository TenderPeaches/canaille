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
                # show client portal
                redirect_to client_portal_path(current_user.client.id)
            # otherwise if user has more than one "business" assigned to
            elsif current_user.user_service_provider_accesses.active.count > 1
                # offer a choice of businesses
                redirect_to user_service_provider_accesses_path
            # otherwise if user has just one business
            elsif current_user.user_service_provider_accesses.active.count == 1
                redirect_to service_provider_portal_path(current_user.service_provider)
            # otherwise, user is not yet client and has no service provider access
            else
                render "home/index"
            end
        else
            render "home/index"
        end
    end
end
