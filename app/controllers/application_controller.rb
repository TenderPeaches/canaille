class ApplicationController < ActionController::Base 
    
    # for features that require login
    def authorize 
        log_in_required if current_user.nil?
    end

    def log_in_required
        redirect_to new_user_session_path, alert: t('alerts.need_log_in')
    end
end
