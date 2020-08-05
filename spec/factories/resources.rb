# == Schema Information
#
# Table name: resources
#
#  id            :bigint           not null, primary key
#  resource_id   :integer
#  resource_type :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_resources_on_resource_id_and_resource_type  (resource_id,resource_type) UNIQUE
#
FactoryBot.define do
  factory :resource do
    resource_type { Faker::Lorem.word }
    sequence(:resource_id) { |n| n }

    trait :user do
      resource_type { 'User' }
      resource_id   { nil }
    end

    trait :form do
      resource_type { 'Form' }
      resource_id   { nil }
    end
  end
end
