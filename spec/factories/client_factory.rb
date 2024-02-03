FactoryBot.define do
    factory :client do 
        user
        coordinate
    
        factory :client_with_service_provider do
            after(:build) do |client|
                user_role = UserRole.find_by_name(:admin) || create(:user_role, name: :admin.to_s)
                client.user.user_service_provider_accesses << build(:user_service_provider_access, user_role: user_role, service_provider: create(:service_provider), user: client.user)
            end
        end
    end
end