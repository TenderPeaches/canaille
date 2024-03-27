FactoryBot.define do
    factory :service do
        sequence(:name) { |n| "Service #{n}"}
        service_category
        service_status { ServiceStatus.active || create(:service_status, :active) }

        trait :pending do
            service_status { ServiceStatus.pending || create(:service_status, :pending) }
        end

    end

    factory :service_category do
        sequence(:label) { |n| "Service Category #{n}" }
    end
end
