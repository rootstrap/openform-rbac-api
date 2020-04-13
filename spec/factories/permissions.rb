FactoryBot.define do
  factory :permission do
    access_type { Permission.access_types.values.sample }
    resource
  end
end
