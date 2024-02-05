FactoryBot.define do 
    factory :service_provider do
        name { Faker::Company.name } 
        coordinate

        factory :active_service_provider do
            after(:build) do |service_provider|
                3.times {
                    service_quotes << create(:service_quote, service_provider: service_provider, status: ServerQuoteStatus.open || create(:service_quote_status_open) )
                }
            end
        end
    end
end