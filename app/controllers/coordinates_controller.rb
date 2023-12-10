class CoordinatesController < ApplicationController
    before_action :set_coordinate, only: %i[ show edit update destroy ]
    before_action :set_or_new_coordinate, only: %i[ use_new_city use_existing_city ]

    def show 

    end 

    def index 
        @coordinates = Coordinate.all
    end 

    def new
        @coordinate = Coordinate.new
    end
    
    def create
        @coordinate = Coordinate.new(coordinate_params)

        if (params[:new_city]) 
            respond_to do |format|
                format.html { render :new }
            end
        else
            respond_to do |format|
                if @coordinate.save
                    format.html { redirect_to coordinates_path, notice: I18n.t('models.coordinate.create_success', id: @coordinate.id.to_s) }
                else
                    format.html { render :new, status: :unprocessable_entity }
                end
            end
        end
    end

    def update
        respond_to do |format|
            if @coordinate.save
                format.html { redirect_to coordinates_path, notice: I18n.t('models.coordinate.update_success', @coordinate.id.to_s) }
                format.turbo_stream
            else
                format.html { render :edit, status: :unprocessable_entity }
                format.turbo_stream
            end
        end
    end

    def destroy
        @coordinate.destroy

        respond_to do |format|
            format.html { redirect_to coordinates_path, notice: I18n.t('models.coordinate.destroy_success') }
            format.turbo_stream
        end
    end

    def use_new_city
        ActionController::Base.helpers.fields model: @coordinate do |form|
            form.fields_for :city, City.new do |city_form|
                respond_to do |format|
                    format.html { render partial: "cities/fields", form: city_form }
                    @form = city_form           # cannot pass locals to stream, so use instance variable instead
                    format.turbo_stream
                end
            end
        end
    end

    def use_existing_city 
        ActionController::Base.helpers.fields model: @coordinate do |form|
            respond_to do |format|
                @form = form           # cannot pass locals to stream, so use instance variable instead
                format.turbo_stream
            end
        end        
    end

    private 
    def set_coordinate 
        @coordinate = Coordinate.find_by_id(params[:id])
    end

    def set_or_new_coordinate
        unless set_coordinate
            @coordinate = Coordinate.new
        end
    end

    def coordinate_params
        params.require(:coordinate).permit(:civic_number, :street_name, :door_number, :postal_code, :notes, :city_id, city_attributes: [ :name, :province_code ])
    end
end
