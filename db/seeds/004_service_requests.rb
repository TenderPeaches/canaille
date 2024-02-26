client = Client.first

ServiceRequest.create(service: Service.find_by_label("Car inspection"), client: client, service_request_status: ServiceRequestStatus.posted)
ServiceRequest.create(service: Service.find_by_label("Expert assessment"), client: client, service_request_status: ServiceRequestStatus.posted)
ServiceRequest.create(service: Service.find_by_label("Tire change"), client: client, service_request_status: ServiceRequestStatus.posted)
ServiceRequest.create(service: Service.find_by_label("Oil change"), client: client, service_request_status: ServiceRequestStatus.posted)
