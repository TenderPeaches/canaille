client = Client.first

ServiceRequest.create(service: Service.find_by_name("Car inspection"), client: client, service_request_status: ServiceRequestStatus.posted)
ServiceRequest.create(service: Service.find_by_name("Expert assessment"), client: client, service_request_status: ServiceRequestStatus.posted)
ServiceRequest.create(service: Service.find_by_name("Tire change"), client: client, service_request_status: ServiceRequestStatus.posted)
ServiceRequest.create(service: Service.find_by_name("Oil change"), client: client, service_request_status: ServiceRequestStatus.posted)
