class ServiceRequestsController < ApplicationController
    before_action :set_service_request, only: %i[ show edit update destroy ]
    before_action :set_or_new_service_request, only: %i[ use_new_city use_existing_city ]
    before_action :set_or_new_city, only: %i[ use_new_city use_existing_city ]
    before_action :authorize, only: %i[ show create edit update destroy ]

    def show

    end

    def index
        @service_rqeuests = ServiceRequest.all
    end

    def new
        @service_request = ServiceRequest.new(service: Service.unknown)
        if user_signed_in?
            @service_request.client = current_user.client
        end
    end

    # creates the service_request
    def create
        create_result = ServiceRequests::Creator.new(current_user).create(service_request_params)

        @service_request = create_result.created

        respond_to do |format|
            if @service_request.valid?
                # redirect to portal
                #? could do service_providers that offer services matching this request's service
                format.html { redirect_to client_portal_path, notice: I18n.t('models.service_request.create_success', id: @service_request.id )}
                format.turbo_stream
            else
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
            format.html { redirect_to client_portal_path, notice: I18n.t('models.service_request.destroy_success') }
            format.turbo_stream
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
        params.require(:service_request).permit(:coordinate_id, :service_id, :notes, :min_price, :max_price, :coordinate_attributes => [ :civic_number, :street_name, :door_number, :postal_code, :notes ], :service_attributes => [:name, :description, :service_category_id], :client_attributes => [ :phone_number, :email_address, :coordinate_attributes => [ :civic_number, :street_name, :door_number, :postal_code, :notes, :use_new_city, :city_attributes  => [ :name, :province_code ]]])
    end
end
