FactoryBot.define do 
    factory :city do
        name { Faker::Address.city } 
        province_code { City.province_codes.sample }
    end
end