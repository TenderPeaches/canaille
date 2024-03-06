class Clients::CoordinatesController < ApplicationController
  def new
  end

  def create
  end

  def edit
      set_client
  end

  def update
      set_client

      if client_params[:coordinate_attributes].has_key? :use_new_city
          city_params = client_params[:coordinate_attributes][:city_attributes]
          @client.coordinate.city = City.create(name: city_params[:name], province_code: city_params[:province_code])
      end

      @client.update(client_params)
  end

  def destroy
  end

  private
  def set_client
      @client = Client.find_by_id(params[:client_id])
  end

  def client_params
      params.require(:client).permit(coordinate_attributes: [:id, :civic_number, :street_name, :door_number, :postal_code, :use_new_city, :notes, :city_id, city_attributes: [:name, :province_code ]])
  end
end
