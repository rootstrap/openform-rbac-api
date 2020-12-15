# == Schema Information
#
# Table name: resources
#
#  id            :bigint           not null, primary key
#  resource_id   :integer
#  resource_type :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  account_id    :bigint
#
# Indexes
#
#  index_resources_on_account_id                                    (account_id)
#  index_resources_on_account_id_and_resource_id_and_resource_type
#  (account_id,resource_id,resource_type) UNIQUE
#
FactoryBot.define do
  factory :resource do
    account

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
