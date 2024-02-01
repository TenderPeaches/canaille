module SpecTestHelper

    # utility auth functions
    def login(user)
        user = User.where(username: user.to_s).first if user.is_a? Symbol
        request.session[:user] = user.id
    end

    def logout
        request.session[:user] = nil
    end

    def current_user
        User.find(request.session[:user])
    end

    # specific user login helpers, must match usernames defined in seeds

    # client has no service provider, just needs services
    def login_client
        login(:client)
    end

    # single service provider
    def login_sp
        login(:bdns)
    end

    # user with multiple service providers
    def login_multiple_sp
        login(:bigwig)
    end

    # user that is both a client and a service provider
    def login_both
        login(:both)
    end
end