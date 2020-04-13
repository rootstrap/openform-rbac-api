FactoryBot.define do
  factory :resource do
    name        { Faker::Name.name }
    resource_id { Faker::Number.within(range: 1..999_999) }
  end
end
