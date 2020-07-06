FactoryBot.define do
  factory :resource do
    resource_type { Faker::Lorem.word }
    sequence(:resource_id) { |n| n }
  end
end
