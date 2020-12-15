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
require 'rails_helper'

RSpec.describe Role, type: :model do
  subject { build :role }
  it { is_expected.to validate_uniqueness_of(:name).scoped_to(:account_id) }
  it { is_expected.to belong_to(:account).required(true) }
end
