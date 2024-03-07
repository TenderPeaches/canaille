FactoryBot.define do
    factory :service do
        sequence(:label) { |n| "Service #{n}"}
        service_category
        service_status { ServiceStatus.active || create(:service_status, :active) }
    end

    factory :service_category do
        sequence(:label) { |n| "Service Category #{n}" }
    end
end
