class ServicesController < ApplicationController
    def new
        @service = Service.new
    end

    def create
        @service = Service.new(service_params)

        @service.save
    end

    private
    def service_params
        params.require(:service).permit(:label, :description, :service_category_id)
    end
end
