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

describe User do
  describe 'validations' do
    subject { build :user }
    it { is_expected.to validate_uniqueness_of(:external_id).scoped_to(:account_id) }
    it { is_expected.to belong_to(:account).required(true) }
  end
end
