module ServiceProviders
    # finds service requests that a service provider might be able to fulfill
    class ServiceRequestFinder
        def initialize(service_provider)
            @service_provider = service_provider
        end

        def find
            # look for service requests that relate to a service that is included in the service provider's service offers
            @requests = ServiceRequest.where(service_id: @service_provider.service_offers.map {|offer| offer.id })
            #! need to add geography-related factors, so closer service providers show up first
            Result.new(@requests)
        end

        class Result
            attr_reader :service_requests

            def initialize(service_requests = [])
                @service_requests = service_requests
            end

            def any?
                @service_requests.any?
            end

            def found
                @service_requests
            end
        end
    end
end
