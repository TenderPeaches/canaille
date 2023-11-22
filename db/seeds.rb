UserRole.create(name: "Admin")
UserRole.create(name: "Employee")

category__mechanic = ServiceCategory.create(category: "Mechanic", description: "", parent: nil)
category__construction = ServiceCategory.create(category: "Construction", description: "", parent: nil)
category__transportation = ServiceCategory.create(category: "Transportation", description: "", parent: nil)