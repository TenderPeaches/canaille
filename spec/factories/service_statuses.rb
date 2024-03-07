FactoryBot.define do
    factory :service_status do
        sequence(:label) { |n| "Service Status ##{n}" }

        trait :active do
            label { "Active" }
        end

        trait :pending do
            label { "Pending" }
        end

        trait :inactive do
            label { "Inactive" }
        end
    end
end
