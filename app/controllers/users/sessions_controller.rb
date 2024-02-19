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
      format.turbo_stream { render embedded_request_response_path }
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

  private
  # use the user's last location to assess where the embedded log-in request was made and return the appropriate response
  def embedded_request_response_path
    # logins embedded within new service request path
    if stored_location_for(:user) == new_service_request_path
      "service_requests/successful_auth"
    end
  end

end
