# == Schema Information
#
# Table name: resources
#
#  id            :bigint           not null, primary key
#  resource_id   :integer
#  resource_type :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_resources_on_resource_id_and_resource_type  (resource_id,resource_type) UNIQUE
#
require 'rails_helper'

RSpec.describe Resource, type: :model do
  subject { create(:resource) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:resource_type) }
    it { is_expected.to validate_presence_of(:resource_type) }
    it do
      is_expected.to validate_uniqueness_of(:resource_type)
        .scoped_to(:resource_id)
        .case_insensitive
    end
  end
end
