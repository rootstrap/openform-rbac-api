# == Schema Information
#
# Table name: users
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  external_id :integer          not null
#
# Indexes
#
#  index_users_on_external_id  (external_id) UNIQUE
#

FactoryBot.define do
  factory :user do
    external_id { Faker::Number.unique.between(from: 1, to: 900).round }
  end
end
