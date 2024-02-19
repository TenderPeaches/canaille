class ApplicationController < ActionController::Base
    before_action :store_user_location!, if: :storable_location?

    # for features that require login
    def authorize
        log_in_required if current_user.nil?
    end

    def log_in_required
        redirect_to new_user_session_path, alert: t('alerts.need_log_in')
    end

    protected

    # use the user's last location to assess where the embedded log-in request was made and return the appropriate response
    def embedded_auth_request_response_path(successful = true)
        turbo_filename = successful ? "successful_auth" : "failed_auth"
        # logins embedded within new service request path
        if stored_location_for(:user) == new_service_request_path
        "service_requests/#{turbo_filename}"
        end
    end

    private
    # https://github.com/heartcombo/devise/wiki/How-To:-Redirect-back-to-current-page-after-sign-in,-sign-out,-sign-up,-update
    def storable_location?
        request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
    end

    def store_user_location!
      store_location_for(:user, request.fullpath)
    end

    # alerts
    def add_alert(*alerts)
      alerts.each do |alert|
        render turbo_stream: turbo_stream.append(:alerts, "application/alert", alert: alert.to_s)
      end
    end
end
