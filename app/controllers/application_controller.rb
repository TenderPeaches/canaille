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

    def embedded_auth_data(url, id = nil)
        if url == new_service_request_path
            {
                var_name: 'service_request',
                record: ServiceRequest.find_by_id(id),
                path: "service_requests",
            }
        end
    end

    # use the user's last location to assess where the embedded log-in request was made and return the appropriate response
    def embedded_auth_request_response_path(url, successful = true)
        turbo_filename = successful ? "successful_auth" : "failed_auth"
        "#{embedded_auth_data(url)[:path]}/#{turbo_filename}"
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
