class ServiceOffersController < ApplicationController
    # called from service_provider/:id/offers
    def index 
        set_service_provider
        @service_offers = ServiceOffer.where(service_provider: @service_provider)
    end

    def new
        set_service_provider
        @service_offer = ServiceOffer.new(service_provider: @service_provider)
        render 'service_providers/portal/new'
    end

    def create
        set_service_provider
        @service_offer = ServiceOffer.new(service_offer_params)
        @service_offer.service_provider = @service_provider

        respond_to do |format|
            if @service_offer.save 
                render 'service_providers/portal/create'
            else
                format.html { render 'service_providers/portal', status: :unprocessable_entity}
            end
        end
    end

    def update
        set_service_offer
        if @service_offer.update(service_offer_params)
            render 'service_providers/portal/update'
        end

    # for edit, :id is service_offer.id
    def edit
        set_service_offer
        render 'service_providers/portal/edit'
    end

    def destroy
        set_service_offer
        @service_offer.destroy
        render 'service_providers/portal/destroy'
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
