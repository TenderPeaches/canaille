class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]

    def index 
        @users = User.all 
    end 

    def show 

    end

    def new
        @user = User.new
    end

    def create 
        @user = User.new(user_params.slice(:email, :username, :password))

        if @user.save
            # if user checked is_client, create a client for them
            if user_params[:is_client]
                @user.client = Client.create
                # don't care about setting client attributes right away - more important to let user start using the site, then ask for client info after posting first request, especially since it involves sensitive information (phone number/email contact)
            end 

            # if user is offering services
            if user_params[:is_service_provider]
                # redirect to service provider create form, assuming that joining an existing provider is an unlikely scenario in the beginning
                redirect_to new_service_provider_path, notice: I18n.t('forms.user.created_success'), user: @user.id
            # otherwise, user is (or is not a client, but doesn't really matter either way; it's just not a service provider)
            else 
                # redirect to the service requests page
                redirect_to "user/#{@user.id}/service_requests", notice: I18n.t('forms.user.created_successs')
            end
        else 
            puts @user.inspect << " not saved:" << @user.errors.full_messages.inspect << " with params " << user_params.inspect
            render :new, status: :unprocessable_entity
        end
    end

    def edit
    end

    def update
        if @user.update(user_params)
            redirect_to users_path, notice: "User updated"
        else
            render :edit
        end
    end

    def destroy
        @quote.destroy
        redirect_to users_path, notice: "User deleted"
    end

    private
    def set_user 
        @user = User.find(params[:id])
    end 

    def user_params
        params.require(:user).permit(:email, :username, :password, :password_confirmation, :is_client, :is_service_provider)
    end
end
