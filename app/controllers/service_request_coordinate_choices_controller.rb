class ServiceRequestCoordinateChoicesController < ApplicationController
    def new
        set_service_request

        if params[:use_client_address]

            choice_result = ServiceRequests::FormAddressPicker.new(current_user).use_client_address

            @service_request = choice_result.service_request
            @coordinate = choice_result.coordinate

            render "service_request_coordinate_choices/use_client_address"

        elsif params[:use_unique_address]

            choice_result = ServiceRequests::FormAddressPicker.new(current_user).use_unique_address

            @service_request = choice_result.service_request

            render "service_request_coordinate_choices/use_unique_address"
        else
            raise 'Wrong param for ServiceRequest::CoordinateChoice'
        end
    end

    private
    def set_service_request
        @service_request = ServiceRequest.find_by_id(params[:service_request_id])
    end
end
