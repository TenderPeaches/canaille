class Clients::ServiceRequestsController < ApplicationController
    before_action :set_service_request
    
    def show
        render 'clients/service_requests/service_request'
    end

    def cancel
        if current_user.client and current_user.client == @service_request.client
            @service_request.service_request_status = ServiceRequestStatus.cancelled
        end
    end

    private
    def set_service_request
        @service_request = ServiceRequest.find_by_id(params[:id])
    end

    def cancel_service_request_params
        #params.require(:service_request).permit(:id)
    end
end