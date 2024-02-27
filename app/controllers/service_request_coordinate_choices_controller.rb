class ServiceRequestCoordinateChoicesController < ApplicationController
    def new
        set_service_request

        if params[:use_client_address]

            choice_result = ServiceRequests::FormAddressPicker.new(current_user).use_client_address

            render "service_requests/use_client_address"
        elsif params[:use_unique_address]

            choice_result = ServiceRequests::FormAddressPicker.new(current_user).use_unique_address

            render "service_requests/use_unique_address"
        else
            raise 'Wrong param for ServiceRequest::CoordinateChoice'
        end
    end

    private
    def set_service_request
        @service_request = ServiceRequest.find_by_id(params[:service_request_id])
    end
end
