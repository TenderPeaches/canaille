class CoordinateCityChoicesController < ApplicationController
    def new
        if params[:use_new_city] == "true"
            use_new_city
        else
            use_existing_city
        end
    end

    private

    def use_new_city
        render "coordinate_city_choices/use_new_city"
    end

    def use_existing_city
        render "coordinate_city_choices/use_existing_city"
    end
end
