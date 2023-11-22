class SessionsController < ApplicationController
    # login screen
    def new 
    end

    # login attempt
    def create
        # start by trying to match the provided username to an existing
        @user = User.find_by_username(user_params[:username])

        # if not found, try to match with existing user emails
        unless @user 
            @user = User.find_by_email(user_params[:email])
        end

        # if user with matching username/email is found,
        if @user
            # attempt to authenticate
            if @user.authenticate(user_params[:password])
                #! need to redirect to [wherever user was going]
                flash[:notice] = I18n.t('forms.sessions.good_auth')
                redirect_to root_url
            # bad auth
            else
                flash[:alert] = I18n.t('forms.session.bad_auth')
                render :new
            end
        # no user matching username or email
        else
            flash[:alert] = I18n.t('forms.session.no_user')
            render :new
        end
    end

    # logout
    def destroy
        session[:user_id] = nil
        flash[:notice] = I18n.t('forms.session.logged_out')
        redirect_to root_url
    end

    private
    def user_params
        params.permit(:email, :username, :password, :authenticity_token, :commit)
    end
end
