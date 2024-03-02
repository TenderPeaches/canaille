# manages how coordinates are assigned to a service request

module ServiceRequests
    class FormAddressPicker
        def initialize(current_user, service_request_id = nil)
            @current_user = current_user
            @service_request_id = @service_request_id
        end

        def use_client_address
            # if the user doesn't already have a client account
            unless @current_user.client
                # initialize their client account
                @current_user.client = Client.new(user: @current_user)
            end

            # set client to the user's client account
            @client = @current_user.client

            # if the client's account exists and has no coordinates set to it
            unless @client&.coordinate
                # initialize the coordinate so fields_for can at least display the fields
                @client.coordinate = Coordinate.new
            end
            # use the user's client account's coordinates as the service_request coordinates
            @coordinate = @client.coordinate

            Result.new(@coordinate)
        end

        def use_unique_address
            set_service_request
            # initialize the coordinate here so fields_for can pick it up and display the form
            Result.new(@service_request.coordinate || Coordinate.new, @service_request)
        end

        class Result
            attr_reader :service_request, :coordinate
            def initialize(coordinate, service_request = nil)
                @coordinate = coordinate
                @service_request = service_request
            end
        end

        private
        # if no service_request provided, initialize a new one. It doesn't matter what its values are, it is only used to generate the proper form by the turbo_stream response
        def set_service_request
            if @service_request_id
                @service_request = ServiceRequest.find_by_id(service_request_id)
            else
                @service_request = ServiceRequest.new
                @service_request.coordinate = Coordinate.new
            end
        end
    end
end
