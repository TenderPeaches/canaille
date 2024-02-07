class ServiceQuoteHistoriesController < ApplicationController
    def index 
        set_service_provider
        render "service_quotes/history"
    end

    private 

    def set_service_provider
        @service_provider = params(:id)
    end
end
