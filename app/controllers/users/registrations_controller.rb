# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
      @user = User.new
  end

  # POST /resource
  def create
      @user = User.new(sign_up_params)

      if @user.save
        # log the user in
        sign_in @user

        # if user checked is_client, create a client for them
        if sign_up_params[:is_client]
            @user.client = Client.create
            # don't care about setting client attributes right away - more important to let user start using the site, then ask for client info after posting first request, especially since it involves sensitive information (phone number/email contact)
        end

        # if user is offering services
        if sign_up_params[:is_service_provider]
            respond_to do |format|
              # redirect to service provider create form, assuming that joining an existing provider is an unlikely scenario in the beginning
              format.html { redirect_to new_service_provider_path(@user.id), notice: I18n.t('models.user.created_success'), user: @user }
              format.turbo_stream { render embedded_auth_request_response_path(params[:source_url], user_signed_in?) }
            end
        # otherwise, user is (or is not a client, but doesn't really matter either way; it's just not a service provider)
        else
            respond_to do |format|
              # redirect to the service requests page
              format.html { redirect_to root_url, notice: I18n.t('models.user.created_success')}
              format.turbo_stream { render embedded_auth_request_response_path(params[:source_url], user_signed_in?) }
            end
        end
    else
        puts @user.errors.full_messages.inspect
        respond_to do |format|
          format.html { render json: @user.errors, status: :unprocessable_entity }
          format.turbo_stream { add_alert(@user.errors.full_messages) }
        end
    end

  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :is_client, :is_service_provider])
  end


  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
