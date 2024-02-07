class ServiceOffersController < ApplicationController
    # called from service_provider/:id/offers
    def index 
        set_service_provider
        @service_offers = ServiceOffer.where(service_provider: @service_provider)
    end

    def new
        @service_offer = ServiceOffer.new(service_provider: @service_provider)
    end

    def create
        @service_offer = ServiceOffer.new(service_offer_params)

        respond_to do |format|
            if @service_offer.save 
                format.turbo_stream
            else
                format.html { render 'service_providers/portal', status: :unprocessable_entity}
            end
        end
    end

    # for edit, :id is service_offer.id
    def edit
        set_service_offer
    end

    def destroy
        set_service_offer
    end

    private
    def set_service_offer
        @service_offer = ServiceOffer.find_by_id(params[:id])
    end

    def set_service_provider
        @service_provider = ServiceProvider.find_by_id(params[:id])
    end

    def service_offer_params
        params.require(:service_offer).permit(:service_provider_id)
    end
end
