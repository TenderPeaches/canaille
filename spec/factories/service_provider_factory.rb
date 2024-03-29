FactoryBot.define do
    factory :service_provider do
        name { Faker::Company.name }
        coordinate
        phone_number { Faker::PhoneNumber.phone_number }
        email_address { Faker::Internet.email }

        factory :active_service_provider do
            after(:build) do |service_provider|
                grantor = service_provider.user_service_provider_accesses&.first&.user || create(:user)
                # make quotes
                3.times {
                    service_provider.service_quotes << create(:service_quote, service_provider: service_provider, status: ServiceQuoteStatus.open || create(:service_quote_status, :open), user: grantor)
                }

                # make service offers
                3.times {
                    service_provider.service_offers << create(:service_offer, service_provider: service_provider)
                }
            end
        end
    end

    factory :service_offer do
        service
        min_price { 10.0 + rand(500.0) }
    end
end
