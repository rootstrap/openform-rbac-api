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
