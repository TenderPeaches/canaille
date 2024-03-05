module ServiceProviders
    class Search
        # any of the args can be used as a search filter:
        #   service_request => service providers that could quote on this (by virtue of being close & offering the service)
        #   client => service providers that are close to this client's coordinate
        #   service => service providers that offer a given service
        def initialize(service_request = nil, client = nil, service = nil)
            @service_request = service_request
            @client = client
            @service = service
        end

        def search

        end

        class Result
            attr_reader :service_providers
            def initialize(service_providers)
                @service_providers = service_providers
            end

            def any?
                @service_providers.any?
            end
        end
    end
end
