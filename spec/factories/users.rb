# == Schema Information
#
# Table name: users
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  external_id :integer
#  account_id  :bigint
#
# Indexes
#
#  index_users_on_account_id                  (account_id)
#  index_users_on_external_id_and_account_id  (external_id,account_id) UNIQUE
#

FactoryBot.define do
  factory :user do
    account
    external_id { Faker::Number.unique.between(from: 1, to: 900).round }
  end
end
