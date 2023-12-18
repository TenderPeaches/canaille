class ServiceOffersController < ApplicationController
    # called from service_provider/:id/offers
    def index 
        @service_offers = ServiceOffer.where(service_provider_id: params[:id])
    end
end
