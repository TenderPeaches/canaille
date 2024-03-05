# searches for a service_provider, can be called from a service_request or a client
class ServiceProviderSearchesController < ApplicationController
    before_action :set_service_request, :set_client

    def new
    end

    def create
        searcher = ServiceProviders::Search.new(@service_request, @client)
        search_results = searcher.search
        if search_results.any?
            @service_providers = search_results.service_providers
        else
            @service_providers = nil
        end
    end

    private
    def set_service_request
        @service_request = ServiceRequest.find_by_id(params[:service_request_id])
    end

    def set_client
        @client = Client.find_by_id(params[:client_id])
    end
end
