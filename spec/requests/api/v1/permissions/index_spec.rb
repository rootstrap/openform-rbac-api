describe 'GET api/v1/permissions', type: :request do
  let!(:account)     { create(:account) }
  let!(:user)        { create(:user, account: account) }
  let!(:user2)       { create(:user, account: account) }
  let!(:role)        { create(:role, account: account).decorate }
  let!(:role2)       { create(:role, account: account).decorate }
  let!(:role_admin)  { create(:role, account: account, name: 'admin').decorate }
  let!(:resource)    { create(:resource) }
  let!(:resource2)   { create(:resource) }
  let!(:permission)  { create(:permission, resource: resource) }
  let!(:permission2) { create(:permission, resource: resource2) }
  let!(:assignment2) { create(:assignment, user: user2, role: role2) }

  let(:headers)        { auth_headers }
  let(:params)         { {} }

  context 'When retrieving a user list of permissions' do
    subject do
      get api_v1_user_permissions_path(user.external_id), params: params,
                                                          headers: headers, as: :json
    end

    context 'when user has one role' do
      let!(:assignment)      { create(:assignment, user: user, role: role) }
      let!(:role_permission) { create(:role_permission, role: role, permission: permission) }

      it 'returns a successfull response' do
        subject
        expect(response).to have_http_status(:success)
      end

      it 'returns only the the permission assigned to the role' do
        expected = {
          permissions: [
            {
              access_type: permission.access_type,
              resource: { resource_id: resource.resource_id, resource_type: resource.resource_type }
            }
          ]
        }
        subject
        expect(json).to include_json(expected)
      end
    end

    context 'when user has more than one role' do
      let!(:assignment)       { create(:assignment, user: user, role: role) }
      let!(:assignment2)      { create(:assignment, user: user, role: role2) }
      let!(:role_permission)  { create(:role_permission, role: role, permission: permission) }
      let!(:role_permission2) { create(:role_permission, role: role2, permission: permission) }
      let!(:role_permission3) { create(:role_permission, role: role2, permission: permission2) }

      it 'returns a successfull response' do
        subject
        expect(response).to have_http_status(:success)
      end

      it 'returns the permissions assigned to both roles' do
        expected = {
          permissions: [
            {
              access_type: permission.access_type,
              resource: { resource_id: resource.resource_id,
                          resource_type: resource.resource_type }
            },
            {
              access_type: permission2.access_type,
              resource: { resource_id: resource2.resource_id,
                          resource_type: resource2.resource_type }
            }
          ]
        }
        subject
        expect(json).to include_json(expected)
      end
    end
  end

  context 'When retrieving a role list of permissions' do
    subject { get api_v1_role_permissions_path(role), params: params, headers: headers, as: :json }

    context 'when user has one role' do
      let!(:role_permission) { create(:role_permission, role: role, permission: permission) }

      it 'returns a successfull response' do
        subject
        expect(response).to have_http_status(:success)
      end

      it 'returns only the the permission assigned to the role' do
        expected = {
          permissions: [
            {
              access_type: permission.access_type,
              resource: { resource_id: resource.resource_id, resource_type: resource.resource_type }
            }
          ]
        }
        subject
        expect(json).to include_json(expected)
      end
    end

    context 'when the role has more than one permission' do
      let!(:role_permission)  { create(:role_permission, role: role, permission: permission) }
      let!(:role_permission2) { create(:role_permission, role: role, permission: permission2) }

      it 'returns a successfull response' do
        subject
        expect(response).to have_http_status(:success)
      end

      it 'returns the permissions assigned to the role' do
        expected = {
          permissions: [
            {
              access_type: permission.access_type,
              resource: { resource_id: resource.resource_id,
                          resource_type: resource.resource_type }
            },
            {
              access_type: permission2.access_type,
              resource: { resource_id: resource2.resource_id,
                          resource_type: resource2.resource_type }
            }
          ]
        }
        subject
        expect(json).to include_json(expected)
      end
    end
  end

  context 'When retrieving a all permissions as an admin' do
    subject { get api_v1_permissions_path, params: params, headers: headers, as: :json }

    context 'when querying permissions assigned to any tole' do
      let!(:assignment)       { create(:assignment, user: user, role: role_admin) }
      let!(:role_permission)  { create(:role_permission, role: role, permission: permission) }
      let!(:role_permission2) { create(:role_permission, role: role2, permission: permission2) }

      it 'returns a successfull response' do
        subject
        expect(response).to have_http_status(:success)
      end

      it 'returns the permissions assigned to any role' do
        expected = {
          permissions: [
            {
              access_type: permission.access_type,
              resource: { resource_id: resource.resource_id,
                          resource_type: resource.resource_type }
            },
            {
              access_type: permission2.access_type,
              resource: { resource_id: resource2.resource_id,
                          resource_type: resource2.resource_type }
            }
          ]
        }
        subject
        expect(json).to include_json(expected)
      end
    end
  end
end
