FactoryBot.define do
    factory :user do
        email { Faker::Internet.email }
        username { Faker::Internet.username }
        password { Faker::Internet.password }
        
        factory :user_with_service_provider do

            after(:build) do |user|
                user_role = UserRole.find_by_name(:admin) || create(:user_role, { name: :admin.to_s })
                user.user_service_provider_accesses << build(:user_service_provider_access, service_provider: create(:service_provider), user: user, user_role: user_role)
            end
        end

        factory :user_with_service_provider_not_admin do 

            after(:build) do |user|
                user.user_service_provider_accesses << build(:user_service_provider_access, service_provider: create(:service_provider), user: user, user_role: create(:user_role))
            end
        end

        factory :user_with_multiple_service_providers do

            after(:build) do |user|
                user_role = UserRole.find_by_name(:admin) || create(:user_role, { name: :admin.to_s })
                2.times { user.user_service_provider_accesses << build(:user_service_provider_access, service_provider: create(:service_provider), user: user, user_role: user_role) }
            end
        end
    end

    factory :user_service_provider_access do
        user
        service_provider
        user_role
    end
end