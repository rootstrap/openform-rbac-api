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

describe User do
  describe 'validations' do
    subject { build :user }
    it { is_expected.to validate_uniqueness_of(:external_id) }
  end
end
