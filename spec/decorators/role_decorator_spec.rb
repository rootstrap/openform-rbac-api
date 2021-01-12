require 'rails_helper'

RSpec.describe RoleDecorator do
  let(:resource) { create(:resource) }
  let(:resource2) { create(:resource) }
  let(:permission) { create(:permission, resource: resource) }
  let(:permission2) { create(:permission, resource: resource2) }
  let!(:role) { create(:role).decorate }

  describe '#permissions_string' do
    subject { role.permissions_string }

    context 'when the role has permissions' do
      let!(:role_permission) { create(:role_permission, role: role, permission: permission) }
      let!(:role_permission2) { create(:role_permission, role: role, permission: permission2) }

      it 'returns the permissions names in a string' do
        permissions_string = role.permissions.map(&:to_s).uniq.join(',')
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
