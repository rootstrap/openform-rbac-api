describe 'PUT api/v1/users/:id', type: :request do
  let!(:user)            { create(:user, resources: []) }
  let!(:user2)           { create(:user, resources: []) }
  let!(:user_resource)   { create(:resource, :user) }
  let!(:form_resource)   { create(:resource, :form) }
  let!(:admin_user_role) { create(:role, :admin, resource: user_resource, user: user) }
  let(:headers)          { auth_headers }
  let(:params)           { { user: {} } }
  subject { put api_v1_user_path(user2.external_id), params: params, headers: headers, as: :json }
  before do
    Permission.access_types.keys.each { |key| Permission.find_or_create_by(access_type: key) }
    user.reload
  end

  context 'with roles params' do
    let(:params) { valid_params }

    it 'assigns the form resource to the user' do
      subject
      added_resource = user2.roles.last.resource
      expect([added_resource.resource_id, added_resource.resource_type]).to eq([1, 'Form'])
    end

    it 'has only one role' do
      subject
      expect(user2.roles.count).to eq(1)
    end

    it 'creates a role with the admin permissions' do
      subject
      created_role = user2.roles.last
      expect(created_role.permissions.pluck(:access_type).sort).to eq(Permission.access_types
        .keys.sort)
    end
  end

  context 'with empty roles params' do
    let!(:admin_form_role) { create(:role, :admin, resource: form_resource, user: user2) }
    let(:params)           { { user: { roles: [] } } }

    it 'removes the existing roles' do
      expect { subject }.to change { Role.count }.by(-1)
    end
  end

  let(:valid_params) do
    {
      user: {
        roles: [
          {
            resource_id: '1',
            resource_type: 'Form',
            name: 'admin'
          }
        ]
      }
    }
  end
end
