class CoordinatesController < ApplicationController
    before_action :set_coordinate, only: %i[ show edit update destroy ]

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
                    format.turbo_stream
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

    private 
    def set_coordinate 
        @coordinate = Coordinate.find(params[:id])
    end

    def coordinate_params
        params.require(:coordinate).permit(:civic_number, :street_name, :door_number, :postal_code, :notes, :city_id, city_attributes: [ :name, :province_code ])
    end
end
