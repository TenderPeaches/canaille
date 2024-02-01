FactoryBot.define do 
    factory :coordinate do
        civic_number { Faker::Address.building_number } 
        street_name { Faker::Address.street_name }
        door_number { Faker::Address.secondary_address }
        postal_code { Faker::Address.zip }
        notes { Faker::Lorem.paragraph }
        city { City.first || create(:city) }
    end
end