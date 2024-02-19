class ApplicationController < ActionController::Base
    before_action :store_user_location!, if: :storable_location?

    # for features that require login
    def authorize
        log_in_required if current_user.nil?
    end

    def log_in_required
        redirect_to new_user_session_path, alert: t('alerts.need_log_in')
    end

    private
    # https://github.com/heartcombo/devise/wiki/How-To:-Redirect-back-to-current-page-after-sign-in,-sign-out,-sign-up,-update
    def storable_location?
        request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
    end

    def store_user_location!
      store_location_for(:user, request.fullpath)
    end
end
