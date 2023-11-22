class ServiceProvidersController < ApplicationController

    def new
        @user = nil
        @service_provider = ServiceProvider.new
    end

    def create
        @service_provider = ServiceProvider.new(service_provider_params)

        if @service_provider.save
            redirect_to root_path
        else
            render 'new'
        end

    end

    private
    def service_provider_params
        params.require(:service_provider).permit(:name, :description, :schedule, :phone_number, :email_address, coordinate_attributes: [ :civic_number, :street_name, :appt_number, :postal_code, :notes, city_attributes: [ :id, :name, :province_code ] ])
    end
end
