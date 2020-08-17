require 'rails_helper'

RSpec.describe RoleDecorator do
  let(:role) { create(:role).decorate }

  describe '#permissions_string' do
    subject { role.permissions_string }

    context 'when the role has permissions' do
      let(:permissions) { create_list(:permission, 4, roles: [role]) }

      it 'returns the permissions names in a string' do
        permissions_string = permissions.map(&:access_type).uniq.join(',')

        expect(subject).to eq(permissions_string)
      end
    end

    context 'when the role has no permissions' do
      it 'returns an empty string' do
        expect(subject).to be_empty
      end
    end
  end
end
