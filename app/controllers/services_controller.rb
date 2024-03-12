class ServicesController < ApplicationController
    def new
        @service = Service.new
        set_form
    end

    def create
        @service = Service.new(service_params)

        @service.save
    end

    private
    def service_params
        params.require(:service).permit(:name, :description, :service_category_id)
    end

    # new services can be created by:
    #   a client creating a service request
    #   a service provider announcing its service offers
    # so the service field will be embedded in either a service_request form or a service_offer form
    # so, when returning the turbo_stream response, the form fields generated need to know if they are attributes of a service_request or service_offer service submodel
    # this is the :input_name route parameter
    def set_form
        @input_name = params[:input_name].to_sym

        if [:service_request, :service_offer].include? @input_name
            # transform input name from a symbol like :service_request to a proper class name like ServiceRequest, create an instance of it and use it as a basis for a FormBuilder object that will be used to create the input fields that will be added to the form
            ActionController::Base.helpers.fields model: @input_name.to_s.camelize.constantize.new do |form|
                form.object.service = Service.new
                form.fields_for :service do |service_form|
                    @form = service_form
                end
            end
        else
            @form = nil
        end
    end
end
