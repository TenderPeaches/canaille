class ClientsController < ApplicationController
    before_action :set_client, only: %i[ show edit update destroy edit_coordinate cancel_edit_coordinate update_coordinate ]

    def show 

    end 

    def index 
        @clients = Client.all
    end 

    def new
        if user_signed_in?
            if current_user.client
                redirect_to { client_portal_path }
            else
                @client = Client.new
            end
        else
            log_in_required
        end
    end

    def new_coordinate

    end

    def edit_coordinate
        @coordinate = @client.coordinate || Coordinate.new
        respond_to do |format|
            format.turbo_stream { render 'clients/portal/edit_coordinate' }
        end
    end

    def cancel_edit_coordinate
        respond_to do |format|
            format.turbo_stream { render 'clients/portal/cancel_edit_coordinate' }
        end
    end
    
    # creates a new client for the current user, or updates it if that user's client has already been set
    def create
        # create/update depending on if current user's client already exists
        if current_user.client
            @client = current_user.client
        else
            @client = Client.new(client_params)
            current_user.client = @client
        end

        respond_to do |format|
            if @client.save
                format.html { redirect_to client_portal_path, notice: t('models.clients.create_success')}
            else
                format.html { redirect_to :new, status: :unprocessable_entity }
            end
        end
    end

    def update
        respond_to do |format|
            if @client.save
                puts "success: #{@client.coordinate.inspect}"
                format.html { redirect_to client_portal_path, notice: I18n.t('models.client.update_success', @client.id.to_s) }
                format.turbo_stream
            else
                puts @client.errors.full_messages.inspect
                format.html { render :edit, status: :unprocessable_entity }
                format.turbo_stream
            end
        end
    end

    def update_coordinate
        @client.coordinate.update(client_params[:coordinate_attributes])
        if params[:coordinate_attributes][:use_new_city]
            @client.coordinate.city = City.create(name: client_params[:coordinate_attributes][:city_attributes][:name], province_code: client_params[:coordinate_attributes][:city_attributes][:province_code])
        end
        respond_to do |format|
            if @client.save
                format.turbo_stream 
            end
        end
    end 

    def destroy
        @client.destroy

        respond_to do |format|
            format.html { redirect_to clients_path, notice: I18n.t('models.client.destroy_success') }
            format.turbo_stream
        end
    end  
    
    def portal
        @user = current_user
        respond_to do |format|
            unless @user.client
                format.html { redirect_to new_client_path }
            else
                format.html { render "clients/portal" }
            end
        end            
    end
    
    private 
    def set_client 
        @client = Client.find(params[:id])
    end

    def client_params
        params.require(:client).permit(coordinate_attributes: [ :civic_number, :street_name, :door_number, :postal_code, :use_new_city, :city_id, city_attributes: [:name, :province_code ]])
    end
end
