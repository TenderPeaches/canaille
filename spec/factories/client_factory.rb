FactoryBot.define do
    factory :client do 
        user
        coordinate
    
        factory :client_with_service_provider do
            after(:build) do |client|
                client.user.user_service_provider_accesses << build(:user_service_provider_access, user_role: UserRole.find_by_name("Admin") || create(:user_role, name: "Admin"), service_provider: create(:service_provider), user: client.user)
            end
        end
    end
end