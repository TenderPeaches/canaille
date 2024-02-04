FactoryBot.define do 
    factory :service do
        name { ["Oil change", "Tire change", "Fridge repair"] } 
    end
    
    factory :service_category do
        sequence(:label) { |n| "Service Category #{n}" }
    end
end