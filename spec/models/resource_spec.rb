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
require 'rails_helper'

RSpec.describe Resource, type: :model do
  subject { create(:resource) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:resource_type) }
    it { is_expected.to validate_presence_of(:resource_type) }
    it { is_expected.to validate_presence_of(:account_id) }
  end
end
