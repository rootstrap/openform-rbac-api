describe 'GET api/v1/roles', type: :request do
  let!(:account)        { create(:account) }
  let!(:user)           { create(:user, account: account) }
  let!(:role)           { create(:role, account: account).decorate }
  let!(:resource)       { create(:resource) }
  let!(:resource2)      { create(:resource) }
  let!(:permission)     { create(:permission, resource: resource) }
  let!(:permission2)    { create(:permission, resource: resource2) }
  let(:headers)         { auth_headers }
  let(:params) do
    {
      permission_ids: [permission.id, permission2.id]
    }
  end

  subject { post assign_api_v1_role_path(role), params: params, headers: headers, as: :json }

  context 'when role has one permission assigned' do
    let!(:role_permission) { create(:role_permission, role: role, permission: permission) }

    it 'resturns a successfull response' do
      subject
      expect(response).to have_http_status(:success)
    end

    it 'Increases the number of RolePermission' do
      expect { subject }.to change { RolePermission.count }.from(1).to(2)
    end

    it 'Increases the permissions of the role' do
      expect { subject }.to change { role.permissions.count }.from(1).to(2)
    end
  end

  context 'when role has all permissions assigned' do
    let!(:role_permission)  { create(:role_permission, role: role, permission: permission) }
    let!(:role_permission2) { create(:role_permission, role: role, permission: permission2) }

    it 'returns a successfull response' do
      subject
      expect(response).to have_http_status(:success)
    end

    it 'Increases the number of RolePermission' do
      expect { subject }.not_to change { RolePermission.count }
    end

    it 'Increases the permissions of the role' do
      expect { subject }.not_to change { role.permissions.count }
    end
  end

  context 'When the role doesnt have any permissions' do
    it 'returns a successfull response' do
      subject
      expect(response).to have_http_status(:success)
    end

    it 'Increases the number of RolePermission' do
      expect { subject }.to change { RolePermission.count }.from(0).to(2)
    end

    it 'Increases the permissions of the role' do
      expect { subject }.to change { role.permissions.count }.from(0).to(2)
    end
  end
end
