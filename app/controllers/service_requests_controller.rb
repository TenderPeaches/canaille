class ServiceRequestsController < ApplicationController
    before_action :set_service_request, only: %i[ show edit update destroy ]
    before_action :set_or_new_service_request, only: %i[ use_client_address use_unique_address use_new_city use_existing_city ]
    before_action :set_or_new_city, only: %i[ use_new_city use_existing_city ]
    before_action :authorize, only: %i[ show create edit update destroy use_client_address ]

    def show 

    end 

    def index 
        @service_rqeuests = ServiceRequest.all
    end 

    def new
        @service_request = ServiceRequest.new
    end
    
    # creates the service_request
    def create
        @service_request = ServiceRequest.new(service_request_params)

        # set service request client
        if current_user.client.nil?
            current_user.client = Client.create()
        end

        # in case client exists but coordinates have not been set, make sure they are instanciated
        if service_request_params[:client_attributes] && current_user.client.coordinate.nil?
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
            # save the client coordinates
            if client_coordinate.save
                # if valid
                current_user.client.update(coordinate: client_coordinate) 
            # invalid coordinates, maybe warn the user or something
            else 
            end
        end

        # link the service request with the user's client account
        @service_request.client = current_user.client

        # set service request status
        @service_request.service_request_status = ServiceRequestStatus.default
        
        # set service request 
        @service_request.service ||= Service.unknown   

        respond_to do |format| 
            if @service_request.save
                # redirect to portal
                #? could do service_providers that offer services matching this request's service
                format.html { redirect_to client_portal_path, notice: I18n.t('models.service_request.create_success', id: @service_request.id )}
                format.turbo_stream
            else
                puts @service_request.errors.inspect
                format.html { render :new, status: :unprocessable_entity, alert: @service_request.errors.full_messages }
                format.turbo_stream
            end
        end
    end

    def update
        respond_to do |format|
            if @service_request.save
                format.html { redirect_to user_service_requests_path, notice: I18n.t('models.service_request.update_success', @service_request.id.to_s) }
                format.turbo_stream
            else
                format.html { render :edit, status: :unprocessable_entity }
                format.turbo_stream
            end
        end
    end

    def destroy
        @service_request.destroy

        @remaining_requests_count = current_user.client.active_service_requests

        respond_to do |format|
            format.html { redirect_to client_portal_path(current_user.id), notice: I18n.t('models.service_request.destroy_success') }
            format.turbo_stream
        end
    end

    def use_client_address
        
        # if the user doesn't already have a client account
        unless current_user.client
            # create their client account
            current_user.client = Client.create(user: current_user)
        end

        # set client to the user's client account
        @client = current_user.client

        # if the client's account has no coordinates set to it
        unless @client.coordinate
            # initialize the coordinate so fields_for can at least display the fields
            @client.coordinate = Coordinate.new
        end 
        # use the user's client account's coordinates as the service_request coordinates
        @coordinate = @client.coordinate
        
        # set the service request's client to be the user's client account
        @service_request.client = @client     

        respond_to do |format|
            format.html 
            format.turbo_stream
        end
    end

    def use_unique_address
        @service_request.coordinate ||= Coordinate.new
        respond_to do |format|
            format.html
            format.turbo_stream { render 'use_unique_address' }
        end
    end

    #(!) this needs to be a coordinates#use_new_city
    def use_new_city

        respond_to do |format|
            if (params[:source] == "service_request_coordinate_attributes_use_new_city")
                format.turbo_stream { render "service_requests/use_new_city" }
            elsif (params[:source] == "service_request_client_attributes_coordinate_attributes_use_new_city")
                format.turbo_stream { render "clients/use_new_city" }
            end
        end
    end

    private 
    def set_or_new_service_request
        unless set_service_request
            @service_request = ServiceRequest.new
        end
    end

    def set_or_new_city 
        @service_request.coordinate ||= Coordinate.new
        @service_request.coordinate.city ||= City.new
    end

    def set_service_request 
        @service_request = ServiceRequest.find_by_id(params[:id])
    end

    def service_request_params
        params.require(:service_request).permit(:coordinate_id, :service_id, :notes, :min_price, :max_price, :coordinate_attributes => [ :civic_number, :street_name, :door_number, :postal_code, :notes ], :service_attributes => [:label, :description], :client_attributes => [ :phone_number, :email_address, :coordinate_attributes => [ :civic_number, :street_name, :door_number, :postal_code, :notes, :use_new_city, :city_attributes  => [ :name, :province_code ]]])
    end
end
