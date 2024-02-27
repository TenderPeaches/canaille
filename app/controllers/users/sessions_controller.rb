# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    # overwriting Devise behavior to more easily manage post-login redirections
    # https://github.com/heartcombo/devise/blob/main/app/controllers/devise/sessions_controller.rb

    # identifying the user that wants to sign in
    self.resource = warden.authenticate!(auth_options)

    set_flash_message!(:notice, :signed_in)

    # sign in the user
    sign_in(resource_name, resource)
    yield resource if block_given?

    respond_to do |format|
      # turbo_stream-type requests are embedded in a page, so the response depends on the page which generated the request
      #! when using turbo_stream response, require :source_url to be passed along as a way for this generic controller to know which specific feature had a embedded login attempt
      format.turbo_stream {
          embedded_data = embedded_auth_data(params[:source_url], params[:id])
          self.instance_variable_set("@#{embedded_data[:var_name]}", embedded_data[:record])
          render embedded_auth_request_response_path(params[:source_url], user_signed_in?)
      }
      # html-type requests get redirected to the root
      format.html { redirect_to root_path }
    end
  end

  # DELETE /resource/sign_out
  def destroy
    super
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  #
  private

  #! embedded auth forms allow an ID to be sent to be retrieved by the controller, in order to adjust the form the auth widget was embedded in
  def set_embedded_id

  end

end
