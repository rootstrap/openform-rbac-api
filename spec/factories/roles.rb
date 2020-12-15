# == Schema Information
#
# Table name: roles
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string
#  account_id :bigint           not null
#
# Indexes
#
#  index_roles_on_account_id           (account_id)
#  index_roles_on_name_and_account_id  (name,account_id) UNIQUE
#
FactoryBot.define do
  factory :role do
    account
    name { Faker::Name.unique.name }
  end
end
