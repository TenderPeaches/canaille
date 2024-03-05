FactoryBot.define do
    factory :service_request do
        client { Client.first || create(:client, user: create(:user)) }
        service
        service_request_status { ServiceRequestStatus.posted || create(:service_request_status, :posted) }
    end

    factory :service_request_status do
        sequence(:label) { |n| "Service Request Status #{n}" }

        trait :created do
          label { "Created" }
        end

        trait :posted do
          label { "Posted" }
        end

        trait :cancelled do
          label { "Cancelled" }
        end

        trait :accepted do
          label { "Accepted" }
        end

        trait :closed do
          label { "Closed" }
        end
    end
end
