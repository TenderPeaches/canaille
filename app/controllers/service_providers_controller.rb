class ServiceProvidersController < ApplicationController
    before_action :set_service_provider, only: %i[ show edit update destroy ask_quote service_offers ]
    before_action :set_user, only: %i[ new create updates destroy ]
    before_action :authorize, only: %i[ :portal ]
    
    # maybe should be moved to another namespace

    def show
    end

    def index_for_client
        @service_providers = ServiceProvider.all
    end

    def new
        @service_provider = ServiceProvider.new
        @service_provider.coordinate = Coordinate.new
    end

    def create
        @service_provider = ServiceProvider.new(service_provider_params)

        if @service_provider.save

            # assume whoever created the service provider is the admin, so create the user's access
            if UserServiceProviderAccess.new(user_id: current_user.id, service_provider_id: @service_provider.id, user_role: UserRole.admin, grantor_id: current_user.id, active_from: Time.now)
                redirect_to service_provider_portal_path
            end
            render 'new', status: :unprocessable_entity
        else
            render 'new', status: :unprocessable_entity
        end
    end

    def update 
        respond_to do |format|
            if @service_provider.save
                format.html { redirect_to service_providers_path, notice: I18n.t('models.service_provider.update_success', @service_provider.id.to_s) }
                format.turbo_stream
            else
                format.html { render :edit, status: :unprocessable_entity }
                format.turbo_stream
            end
        end
    end

    def destroy
        @service_provider.destroy

        respond_to do |format|
            format.html { redirect_to service_providers_path, notice: I18n.t('models.service_provider.destroy_success') }
            format.turbo_stream
        end
    end

    def browse_service_requests
        
    end

    # actual service_provider params

    def index
        @service_providers = ServiceProvider.all
    end

    #!! ?
    def service_ask_quote
        @service = params(:service_id)
    end

    def portal 
        # if provided a service provided ID
        if params[:service_provider_id]
            # open the portal for that service provider
            @service_provider = ServiceProvider.find_by_id(:service_provider_id)
        # otherwise
        else
            # default to the user's first service provider
            @service_provider = current_user.service_provider
        end
    end
    
    # p2
    def offer_help
        @user = current_user
    end

    private
    def set_user 
        @user = current_user
    end 

    def set_service_provider
        @service_provider = ServiceProvider.find_by_id(params[:id])
    end 

    def set_or_new_service_provider
        unless set_service_provider
            @service_provder = ServiceProvider.new
        end
    end

    def service_provider_params
        params.require(:service_provider).permit(:name, :description, :schedule, :phone_number, :email_address, coordinate_attributes: [ :civic_number, :street_name, :door_number, :postal_code, :notes, :city_id, city_attributes: [ :id, :name, :province_code ] ])
    end
end
