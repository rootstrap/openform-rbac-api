# == Schema Information
#
# Table name: accounts
#
#  id         :bigint           not null, primary key
#  name       :string
#  api_key    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_accounts_on_api_key  (api_key) UNIQUE
#
FactoryBot.define do
  factory :account do
    name { 'Account Name' }
  end
end
