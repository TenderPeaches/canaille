module ServiceRequests
    # finds service providers that could realistically potentially fulfill this service request
    class ServiceProviderFinder
        def initialize(service_request)
            @service_request = service_request
        end

        def find
            #! need to add geography-related factors, so closer service providers show up first
            Result.new(ServiceOffer.where(service_id: service_id).includes(:service_provider))
        end
    end
end
