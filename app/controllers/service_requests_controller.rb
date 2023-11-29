class ServiceRequestsController < ApplicationController
    before_action :set_service_request, only: %i[ show edit update destroy ]

    def show 

    end 

    def index 
        @service_rqeuests = ServiceRequest.all
    end 

    def new
        @service_request = ServiceRequest.new
    end
    
    def create
        @service_request = ServiceRequest.new(service_request_params)

        respond_to do |format|
            if @service_request.save
                format.html { redirect_to user_service_requests_path, notice: I18n.t('models.service_request.create_success', @service_request.id.to_s) }
                format.turbo_stream
            else
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

    private 
    def set_service_request 
        @service_request = ServiceRequest.find(params[:id])
    end

    def service_request_params
        params.require(:service_request).permit(:service_id, :coordinate_id, :service_id, :coordinate_attributes => [ :civic_number, :street_name, :door_number, :postal_code, :notes, :city_id ], :service_attributes => [:label, :description])
    end
end
