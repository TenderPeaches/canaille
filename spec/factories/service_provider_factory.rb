FactoryBot.define do 
    factory :service_provider do
        name { Faker::Company.name } 
        coordinate

        factory :active_service_provider do
            
        end
    end
end