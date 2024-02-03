# Fake user/service provider data, used to test stuff

# Cities
city__sherbrooke = City.create(name: "Sherbrooke", province_code: "QC")

# Users 
user = User.create! username: "user", email: "some_user@gmail.com", password: 1234, password_confirmation: 1234
user__client = User.create! username: "client", email: "some_client@gmail.com", password: "1234", password_confirmation: "1234"
user__sp = User.create! username: "bdns", email: "some_bdns@gmail.com", password: "1234", password_confirmation: "1234"
user__bigwig = User.create! username: "bigwig", email: "ceo@gmail.com", password: "1234", password_confirmation: "1234"
user__both = User.create! username: "both", email: "some_client_and_bdns@gmail.com", password: "1234", password_confirmation: "1234"

# Clients
user__client.client = Client.create(coordinate: Coordinate.create(civic_number: "2020", street_name: "du Finfin", door_number: "2", postal_code: "H3R 3F9", city: city__sherbrooke), phone_number: "5554345151")
user__both.client = Client.create(phone_number: "5551234434")

# Service providers
sp__garage_bob = ServiceProvider.create(name: "Garage chez Bob", description: "Un garage imaginaire", schedule: "non", phone_number: "555-151-5151", email_address: "garage.bob@gmail.com")
sp__fruit_store = ServiceProvider.create(name: "Fruiterie Kiwi", description: "Une fruiterie spécialisée en produits néo-zélandais", schedule: "L-V 9@5", phone_number: "555-222-1321", email_address: "fruit.kiwi@gmail.com")
sp__joe_blow = ServiceProvider.create(name: "", description: "Expert en fignolage", schedule: "24/7", phone_number: "", email_address: "")

# User service providers accesses
UserServiceProviderAccess.create(user: user__sp, service_provider: sp__garage_bob, user_role: UserRole.find_by_name("Admin"), grantor: user__sp)
UserServiceProviderAccess.create(user: user__bigwig, service_provider: sp__garage_bob, user_role: UserRole.find_by_name("Employee"), grantor: user__sp)
UserServiceProviderAccess.create(user: user__bigwig, service_provider: sp__fruit_store, user_role: UserRole.find_by_name("Admin"), grantor: user__bigwig)
UserServiceProviderAccess.create(user: user__both, service_provider: sp__joe_blow, user_role: UserRole.find_by_name("Admin"), grantor: user__both)