FactoryBot.define do 
    factory :service_quote do
        service_request { ServiceRequest.first || create(:service_request) }
        status { ServiceQuoteStatus.first || create(:service_quote_status) }
    end

    factory :service_quote_status do
        sequence(:label) { |n| "Service Quote Status #{n}" }
        factory :service_quote_status_open, class: :service_quote_status do
            label { "Open" }
        end
    end
    
end