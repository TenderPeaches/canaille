FactoryBot.define do 
    factory :service_request do
        client { Client.first || create(:client, user: create(:user)) }
        service
        service_request_status
    end

    factory :service_request_status do
        sequence(:label) { |n| "Service Request Status #{n}" }
    end
end