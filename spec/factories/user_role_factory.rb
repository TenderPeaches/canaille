FactoryBot.define do 
    factory :user_role do
        name { Faker::Job.position }
    end
end