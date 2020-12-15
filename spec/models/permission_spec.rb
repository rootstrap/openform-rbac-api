# == Schema Information
#
# Table name: permissions
#
#  id          :bigint           not null, primary key
#  access_type :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  resource_id :bigint
#
# Indexes
#
#  index_permissions_on_access_type_and_resource_id  (access_type,resource_id) UNIQUE
#  index_permissions_on_resource_id                  (resource_id)
#
require 'rails_helper'

RSpec.describe Permission, type: :model do
  subject { create(:permission) }

  describe 'validations' do
    it { is_expected.to belong_to(:resource).required(true) }
    it { is_expected.to validate_presence_of(:access_type) }
  end
end
