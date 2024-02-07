class ServiceQuotesController < ApplicationController
    # service provider requests a form to submit a quote
    def new
        set_service_provider
        set_service_request
        @service_quote = ServiceQuote.new(service_provider: @service_provider, service_request: @service_request)
    end

    # service provider submits a quote
    def create
        @service_quote = ServiceQuote.new(service_quote_params)
    end

    # service provider withdraws a quote
    def destroy
        set_service_quote

    private 
    def set_service_provider
        @service_provider = ServiceProvider.find(params[:service_provider_id])
    end

    def set_service_request
        @service_request = ServiceRequest.find(params[:service_request_id])
    end

    def set_service_quote
        @service_quote = ServiceQuote.find(params[:service_quote_id])
    end

    def service_quote_params
        params.require(:service_quote).permit(:service_request_id, :service_provider_id, :user_id, :price, :notes)
    end
end
