class Clients::ServiceRequestsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_service_request
    
    def show
        render 'clients/service_requests/service_request' if assert_user
    end

    def cancel
        @service_request.service_request_status = ServiceRequestStatus.cancelled if assert_user
    end

    def activate 
        @service_request.service_request_status = ServiceRequestStatus.created if assert_user
    end

    private
    def set_service_request
        @service_request = ServiceRequest.find_by_id(params[:id])
    end

    def assert_user
        if current_user.client and current_user.client == @service_request.client
            return true
        else
            redirect_to client_portal_path(current_user.client), alert: t('alerts.wrong_client')
        end
    end
end