class ServiceProviders::ServiceOffersController < ApplicationController
    # called from service_provider/:id/offers
    def index 
        set_service_provider
        @service_offers = ServiceOffer.where(service_provider: @service_provider)
    end

    def new
        set_service_provider
        @service_offer = ServiceOffer.new(service_provider_id: @service_provider.id)
        render filepath(:new)
    end

    def create
        set_service_provider
        @service_offer = ServiceOffer.new(service_offer_params)
        @service_offer.service_provider = @service_provider

        respond_to do |format|
            if @service_offer.save 
                render filepath(:create)
            else
                format.html { render 'service_providers/portal', status: :unprocessable_entity}
            end
        end
    end

    def update
        set_service_offer
        if @service_offer.update(service_offer_params)
            render filepath(:update)
        end
    end

    # for edit, :id is service_offer.id
    def edit
        set_service_offer
        render filepath(:edit)
    end

    def destroy
        set_service_offer
        @service_offer.destroy
        render filepath(:destroy)
    end

    private
    def set_service_offer
        @service_offer = ServiceOffer.find_by_id(params[:id])
    end

    def set_service_provider
        @service_provider = ServiceProvider.find_by_id(params[:service_provider_id])
    end

    def service_offer_params
        params.require(:service_offer).permit(:service_provider_id)
    end

    def filepath(view)
        "#{view_root}#{view.to_s}"
    end

    def view_root
        "service_providers/portal/service_offers/"
    end
end
