class ServicesController < ApplicationController
    before_action :set_service, only: %i[ show edit update destroy ]=

    def show 
    end 

    def new
        @service = ServiceRequest.new
    end
    
    def create
        @service = ServiceRequest.new(service_params)

        respond_to do |format|
            if @service.save
                format.html { redirect_to services_path, notice: I18n.t('models.service.create_success', @service.id.to_s) }
                format.turbo_stream
            else
                format.html { render :new, status: :unprocessable_entity }
                format.turbo_stream
            end
        end
    end

    def update
        respond_to do |format|
            if @service.save
                format.html { redirect_to services_path, notice: I18n.t('models.service.update_success', @service.id.to_s) }
                format.turbo_stream
            else
                format.html { render :edit, status: :unprocessable_entity }
                format.turbo_stream
            end
        end
    end

    def destroy
        @service.destroy

        respond_to do |format|
            format.html { redirect_to services_path, notice: I18n.t('models.service.destroy_success') }
            format.turbo_stream
        end
    end

    private 
    def set_service 
        @service = ServiceRequest.find(params[:id])
    end

    def service_params
        params.require(:service).permit(:label, :description, :service_category_id)
    end
end
