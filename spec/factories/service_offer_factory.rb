FactoryBot.define do 
    factory :service_offer do
        service { create(:service) }
        service_provider { ServiceProvider.first || create(:service_provider)}
    end
end