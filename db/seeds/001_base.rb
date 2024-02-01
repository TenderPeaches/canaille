# Base seeds - default values for enums/lookup tables, "None" values for optional models

# User roles
UserRole.create(name: "Admin")
UserRole.create(name: "Employee")

# Service request statuses
ServiceRequestStatus.create(label: "Created", description: "The request has been created but has not been published yet")
ServiceRequestStatus.create(label: "Posted", description: "The request has been published but no quote has been approved for this service request")
ServiceRequestStatus.create(label: "Cancelled", description: "The client has cancelled this service request")
ServiceRequestStatus.create(label: "Quote Accepted", description: "The client has accepted a quote for this service request; No more quotes can be submitted")
ServiceRequestStatus.create(label: "Closed", description: "The requested service has been provided")

# Service quote statuses
ServiceQuoteStatus.create(label: "Open", description: "The quote has been submitted and may be chosen by the client")
ServiceQuoteStatus.create(label: "Closed", description: "The client has chosen another quote for their service request")
ServiceQuoteStatus.create(label: "Cancelled", description: "The service provider cancelled the quote before the client could choose it")

# None values 
City.create(name: "N/A", province_code: "N/A")
Coordinate.create(civic_number: "No location")