class ServiceRequestsController < ApplicationController
    before_action :set_service_request, only: %i[ show edit update destroy ]
    before_action :authorize, only: %i[ show edit update destroy use_client_address ]

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

        respond_to do |format|
            if @service_request.save
                # if user is not signed in
                if !user_signed_in
                    # the request is created, but the user should still be prompted to create an account
                    # if the account isn't created, the service_request is devalued accordingly but can still exist as a "well that's what it is"
                    log_in_required
                # if user is signed in, but does not have a client account
                elsif current_user.client.nil? 
                    # prompt them to create a client
                    #! since the service_request expects a client_id, might need to make it user_id instead? so that it doesn't get lost if user does not create client here
                    format.html { redirect_to new_client_path, alert: I18n.t('alerts.need_create_client') }
                # otherwise, user is signed in and has a client account
                else
                    # redirect to portal
                    #? could do service_providers that offer services matching this request's service
                    format.html { redirect_to portal_client_path, notice: I18n.t('models.service_request.create_success')}
                end
                format.turbo_stream
            else
                puts @service_request.errors.inspect
                format.html { render :new, status: :unprocessable_entity }
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

        respond_to do |format|
            format.html { redirect_to user_service_requests_path(@user.id), notice: I18n.t('models.service_request.destroy_success') }
            format.turbo_stream
        end
    end

    def use_client_address
        @client = current_user.client
        #! @authorize
        if @client
            coordinate = @client.coordinate
        else 
            coordinate = "Random address, need to get from logged in user/client"
        end
        respond_to do |format|
            format.html 
            format.turbo_stream { render 'use_client_address', locals: { coordinate: coordinate }}
        end
    end

    def use_unique_address
        @coordinate = Coordinate.new 
        
        respond_to do |format|
            format.html
            format.turbo_stream { render 'use_unique_address' }
        end
    end

    private 
    def set_service_request 
        @service_request = ServiceRequest.find(params[:id])
    end

    def service_request_params
        params.require(:service_request).permit(:service_id, :coordinate_id, :service_id, :notes, :min_price, :max_price, :coordinate_attributes => [ :civic_number, :street_name, :door_number, :postal_code, :notes, :city_id ], :service_attributes => [:label, :description])
    end
end
