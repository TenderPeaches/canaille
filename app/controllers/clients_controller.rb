class ClientsController < ApplicationControllerbefore_action :set_client, only: %i[ show edit update destroy ]

    def show 

    end 

    def index 
        @clients = Client.all
    end 

    def new
        if user_signed_in?
            if current_user.client
                redirect_to { portal_client_path }
            else
                @client = Client.new
            end
        else
            log_in_required
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
                format.html { redirect_to portal_client_path, notice: t('models.clients.create_success')}
            else
                format.html { redirect_to :new, status: :unprocessable_entity }
            end
        end
    end

    def update
        respond_to do |format|
            if @client.save
                format.html { redirect_to portal_client_path, notice: I18n.t('models.client.update_success', @client.id.to_s) }
                format.turbo_stream
            else
                format.html { render :edit, status: :unprocessable_entity }
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
                format.html { redirect_to portal_client_path }
            end
        end            
    end
    
    private 
    def set_client 
        @client = Client.find(params[:id])
    end

    def client_params
        params.require(:client).permit(:name, :province_code)
    end
end
