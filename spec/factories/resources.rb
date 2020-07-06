FactoryBot.define do
  factory :resource do
    trait :user do
      resource_type { 'User' }
      resource_id   { nil }
    end

    trait :form do
      resource_type { 'Form' }
      resource_id   { nil }
    end
    resource_type { Faker::Lorem.word }
    sequence(:resource_id) { |n| n }
  end
end
