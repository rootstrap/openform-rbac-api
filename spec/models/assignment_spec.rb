# == Schema Information
#
# Table name: assignments
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  role_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_assignments_on_role_id  (role_id)
#  index_assignments_on_user_id  (user_id)
#
require 'rails_helper'

RSpec.describe Assignment, type: :model do
  describe 'validations' do
    subject { build :assignment }
    it { is_expected.to belong_to(:role).required(true) }
    it { is_expected.to belong_to(:user).required(true) }
  end
end
