# Service statuses

service_status__active = ServiceStatus.create(label: "Active", description: "Service approved for current use")
service_status__pending = ServiceStatus.create(label: "Pending", description: "Pending approval for use")
service_status__inactive = ServiceStatus.create(label: "Inactive", description: "Temporarily or permanently inactive")

# List of service categories and related services

category__mechanic = ServiceCategory.create(label: "Mechanic", description: "", parent: nil)
category__mechanic__car_maintenance = ServiceCategory.create(label: "Car maintenance", description: "", parent: category__mechanic)
category__mechanic__appliance_maintenance = ServiceCategory.create(label: "Appliance maintenance", description: "", parent: category__mechanic)
category__mechanic__hvac_maintenance = ServiceCategory.create(label: "HVAC maintenance", description: "", parent: category__mechanic)
category__mechanic__bicycle_maintenance = ServiceCategory.create(label: "Bicycle maintenance", description: "", parent: category__mechanic)
category__mechanic__electronics_maintenance = ServiceCategory.create(label: "Electronics maintenance", description: "", parent: category__mechanic)
category__construction = ServiceCategory.create(label: "Construction", description: "", parent: nil)
category__construction__carpentry = ServiceCategory.create(label: "Carpentry", description: "", parent: category__construction)
category__construction__roofing = ServiceCategory.create(label: "Roofing", description: "", parent: category__construction)
category__construction__plumbing = ServiceCategory.create(label: "Plumbing", description: "", parent: category__construction)
category__construction__electrical = ServiceCategory.create(label: "Electrical", description: "", parent: category__construction)
category__construction__metalworking = ServiceCategory.create(label: "Metalworking", description: "", parent: category__construction)
category__cleaning = ServiceCategory.create(label: "Cleaning", description: "", parent: nil)
category__cleaning__domestic = ServiceCategory.create(label: "Domestic", description: "", parent: category__cleaning)
category__cleaning__commercial = ServiceCategory.create(label: "Commercial", description: "", parent: category__cleaning)
category__cleaning__industrial = ServiceCategory.create(label: "Industrial", description: "", parent: category__cleaning)
category__transportation = ServiceCategory.create(label: "Transportation", description: "", parent: nil)
category__transportation__ride_sharing = ServiceCategory.create(label: "Ride sharing", description: "", parent: category__transportation)
category__transportation__shuttle = ServiceCategory.create(label: "Shuttle", description: "", parent: category__transportation)
category__transportation__car_sharing = ServiceCategory.create(label: "Car sharing", description: "", parent: category__transportation)
category__food = ServiceCategory.create(label: "Food", description: "", parent: nil)
category__catering = ServiceCategory.create(label: "Catering", description: "", parent: category__food)
category__leftovers = ServiceCategory.create(label: "Leftovers", description: "", parent: category__food)
category__other = ServiceCategory.create(label: "Other", description: "", parent: nil)

Service.create(name: "Custom", description: "Catch-all service", service_category: category__other, service_status: service_status__active)
Service.create(name: "Unknown", description: "Unknown service", service_category: category__other, service_status: service_status__active)

Service.create(name: "Car inspection", description: "", service_category: category__mechanic__car_maintenance, service_status: service_status__active)
Service.create(name: "Expert assessment", description: "", service_category: category__mechanic__car_maintenance, service_status: service_status__active)
Service.create(name: "Tire change", description: "", service_category: category__mechanic__car_maintenance, service_status: service_status__active)
Service.create(name: "Oil change", description: "", service_category: category__mechanic__car_maintenance, service_status: service_status__active)
Service.create(name: "Exterior wash", description: "", service_category: category__mechanic__car_maintenance, service_status: service_status__active)
Service.create(name: "Interior wash", description: "", service_category: category__mechanic__car_maintenance, service_status: service_status__active)
Service.create(name: "Headlight change", description: "", service_category: category__mechanic__car_maintenance, service_status: service_status__active)

Service.create(name: "Expert assessment", description: "", service_category: category__mechanic__appliance_maintenance, service_status: service_status__active)
Service.create(name: "Fridge repair", description: "", service_category: category__mechanic__appliance_maintenance, service_status: service_status__active)
Service.create(name: "Washing machine repair", description: "", service_category: category__mechanic__appliance_maintenance, service_status: service_status__active)
Service.create(name: "Drying machine repair", description: "", service_category: category__mechanic__appliance_maintenance, service_status: service_status__active)
Service.create(name: "Stove repair", description: "", service_category: category__mechanic__appliance_maintenance, service_status: service_status__active)
Service.create(name: "Dishwasher repair", description: "", service_category: category__mechanic__appliance_maintenance, service_status: service_status__active)

Service.create(name: "Expert assessment", description: "", service_category: category__mechanic__hvac_maintenance, service_status: service_status__active)
Service.create(name: "AC repair", description: "", service_category: category__mechanic__hvac_maintenance, service_status: service_status__active)

Service.create(name: "Expert assessment", description: "", service_category: category__mechanic__bicycle_maintenance, service_status: service_status__active)
Service.create(name: "Yearly check-up", description: "", service_category: category__mechanic__bicycle_maintenance, service_status: service_status__active)
Service.create(name: "Flat tire fix", description: "", service_category: category__mechanic__bicycle_maintenance, service_status: service_status__active)
Service.create(name: "Tire change", description: "", service_category: category__mechanic__bicycle_maintenance, service_status: service_status__active)
Service.create(name: "Hub overhaul", description: "", service_category: category__mechanic__bicycle_maintenance, service_status: service_status__active)
