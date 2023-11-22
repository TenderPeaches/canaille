class ApplicationController < ActionController::Base

    def index 
        render "/index"
    end    
    
    # for features that require login
    def authorize 
        redirect_to login_url, alert: "Not authorized, login first" if current_user.nil?
    end

    private 
    def current_user
        # save in instance variable because accessed often
        # only look up if session has a user_id
        @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]     
        #! instead of returning nil if user not found, could also create an anonymus user and return that one
    end
    helper_method :current_user
end
