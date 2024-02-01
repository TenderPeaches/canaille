FactoryBot.define do 
    factory :service_provider do
        name { Faker::Company.name } 
        coordinate
    end
end