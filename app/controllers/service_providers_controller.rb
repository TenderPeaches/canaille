class ServiceProvidersController < ApplicationController
    before_action :set_service_provider, only: %i[ show edit update destroy ]
    before_action :set_user, only: %i[ new create update index_for_user destroy ]
    
    def show
    end

    def index
        @service_providers = ServiceProvider.all
    end

    def index_for_user
        @service_providers = @user.service_providers
    end

    def new
        @service_provider = ServiceProvider.new
        @service_provider.coordinate = Coordinate.new
    end

    def create
        @service_provider = ServiceProvider.new(service_provider_params)

        if @service_provider.save
            redirect_to root_path
        else
            render 'new'
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
