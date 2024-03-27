module ServiceRequests
  # creates a service request
  class Creator
    def initialize(current_user)
      @current_user = current_user
    end

    def create(service_request_params)
        # if user is logged in
        if @current_user
          # unless user client already exists
          unless @current_user.client
              # create the client automatically
              @current_user.client = Client.create(user: @current_user)
          end
          # add the client to the service request parameters
          service_request_params[:client_id] = @current_user.client.id
      end

      # if the user has defined a new service, ignore any service_id attribute and instead use the new service information to create the new service
      # the user is known to have defined a new service if the ":name" attribute exists under the :service_attributes; it does not suffice to only check for the existence of :service_attributes because of the service_category hidden field, which is present at all times
      if (service_request_params.has_key? :service_attributes) && service_request_params[:service_attributes][:name]
          # if the user has created a service whose name is already in use, use that service instead
          service = Service.find_by_name(service_request_params[:service_attributes][:name])

          # only create the service if the name isn't in use
          unless service
              service = Service.create(service_request_params[:service_attributes].merge!(service_status_id: ServiceStatus.default_id))
          end
      else
          service = Service.find_by_id(service_request_params[:service_id])
      end

      # set default service to unkonwn if somehow nil
      service = Service.unknown unless service

      # create the request, in_session: true if user not logged in
      @service_request = ServiceRequest.new(service_request_params)

      # overwrite the service
      @service_request.service = service

      # set the default status
      #! could be made as a default value in the DB, or placed here, out of the model
      @service_request.service_request_status = ServiceRequestStatus.default

      # unless the user specified coordinates, use the client's coordinates and create them if necessary
      unless service_request_params[:coordinate_attributes]
          @service_request.coordinate = set_client_coordinate(@service_request, service_request_params)
      end

      @service_request.save

      Result.new(@service_request, @current_user.nil?)
    end

    class Result
      attr_reader :service_request

      def initialize(service_request = nil, no_user = false)
        @service_request = service_request
        @no_user = no_user
      end

      def created?
        @service_request && @service_request.valid?
      end

      def created
        @service_request
      end

      def no_user?
        @no_user
      end

      def as_json
        @service_request.to_json
      end
    end

    private
    def set_client_coordinate(service_request, service_request_params)

      # if client exists but coordinates have not been set, set them
      if service_request.client && service_request.client.coordinate.nil?
        # if the attributes array exists, the user checked "use new city"
        if service_request_params[:client_attributes][:coordinate_attributes][:city_attributes]
            # create the city before the coordinate
            #! shouldn't this happen on Coordinate.create? look into, could cut this entire block
            client_coordinate_city = City.create(service_request_params[:client_attributes][:coordinate_attributes][:city_attributes])
        end
        # instantiate the client coordinates
        client_coordinate = Coordinate.new(service_request_params[:client_attributes][:coordinate_attributes])
        # if city_id wasn't outright picked by the user, it's assumed that they are inputting a new city
        client_coordinate.city_id ||= client_coordinate_city

        client_coordinate
      end
    end
  end
end
