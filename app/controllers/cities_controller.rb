class CitiesController < ApplicationController
    before_action :set_city, only: %i[ show edit update destroy ]

    def show 

    end 

    def index 
        @cities = City.all
    end 

    def new
        @city = City.new
    end
    
    def create
        @city = City.new(city_params)

        respond_to do |format|
            if @city.save
                format.html { redirect_to cities_path, notice: I18n.t('models.city.create_success', id: @city.id.to_s) }
            else
                format.html { render :new, status: :unprocessable_entity }
                format.turbo_stream
            end
        end
    end

    def update
        respond_to do |format|
            if @city.save
                format.html { redirect_to cities_path, notice: I18n.t('models.city.update_success', @city.id.to_s) }
                format.turbo_stream
            else
                format.html { render :edit, status: :unprocessable_entity }
                format.turbo_stream
            end
        end
    end

    def destroy
        @city.destroy

        respond_to do |format|
            format.html { redirect_to cities_path, notice: I18n.t('models.city.destroy_success') }
            format.turbo_stream
        end
    end
    
    def form__use_new 
        respond_to do |format|

        end
    end

    def form__use_current
        respond_to do |format|

        end
    end

    private 
    def set_city 
        @city = City.find(params[:id])
    end

    def city_params
        params.require(:city).permit(:name, :province_code)
    end
end
