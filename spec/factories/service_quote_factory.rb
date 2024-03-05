FactoryBot.define do
    factory :service_quote do
        service_request { ServiceRequest.first || create(:service_request) }
        status { ServiceQuoteStatus.first || create(:service_quote_status) }
    end

    factory :service_quote_status do
        sequence(:label) { |n| "Service Quote Status #{n}" }

        trait :open do
            label { "Open" }
        end

        trait :closed do
            label { "Closed" }
        end

        trait :cancelled do
            label { "Cancelled" }
        end

        trait :accepted do
            label { "Accepted" }
        end
    end

end
