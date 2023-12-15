class ApplicationController < ActionController::Base

    def index 
        if authorize
            if current_user
            render "/index"
    end    
    
    # for features that require login
    def authorize 
        redirect_to login_url, alert: "Not authorized, login first" if current_user.nil?
    end

    private 
end
