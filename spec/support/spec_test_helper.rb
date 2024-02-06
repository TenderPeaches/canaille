module SpecTestHelper

    # utility auth functions
    # https://github.com/heartcombo/devise/wiki/How-To:-Test-with-Capybara
    def login(user = create(:user))
        login_as(user, scope: :user)
        user
    end

    def logout
        # use Warden logout helper
        logout(:user)
    end

    # specific user login helpers for some user contexts
    # client has no service provider, just needs services
    def login_client
        client = create(:client)
        login(client.user)
    end

    # single service provider
    def login_service_provider
        user = create(:user_with_service_provider)
        login(user)
    end

    # user that is both a client and a service provider
    def login_both
        client = create(:client_with_service_provider)
        login(client.user)
    end

    # user that has multiple service provider accesses
    def login_multi_service_provider
        user = create(:user_with_multiple_service_providers)
        login(user)
    end

    ## identfy the log in required page
    def be_login
        have_test_id('log-in')
    end
end