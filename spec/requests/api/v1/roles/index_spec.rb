describe 'GET api/v1/roles', type: :request do
  let!(:account)        { create(:account) }
  let!(:user)           { create(:user, account: account) }
  let!(:user2)          { create(:user, account: account) }
  let!(:role)           { create(:role, account: account).decorate }
  let!(:role2)          { create(:role, account: account, name: 'admin').decorate }
  let!(:resource)       { create(:resource) }
  let!(:resource2)      { create(:resource) }
  let!(:permission)     { create(:permission, resource: resource) }
  let!(:permission2)    { create(:permission, resource: resource2) }
  let!(:assignment2)    { create(:assignment, user: user2, role: role2) }

  let(:headers)        { auth_headers }
  let(:params)         { {} }

  subject { get api_v1_roles_path, params: params, headers: headers, as: :json }

  context 'When the user is not an admin, return only his roles' do
    context 'when role has permissions assigned' do
      let!(:assignment)      { create(:assignment, user: user, role: role) }
      let!(:role_permission) { create(:role_permission, role: role, permission: permission) }

      it 'resturns a successfull response' do
        subject
        expect(response).to have_http_status(:success)
      end

      it 'returns only the the role and the permission' do
        expected = {
          roles: [
            {
              name: role.name,
              permissions_string: role.permissions_string
            }
          ]
        }
        subject
        expect(json).to include_json(expected)
      end
    end

    context 'when user doesn\'t have any permissions' do
      it 'returns a successfull response' do
        subject
        expect(response).to have_http_status(:success)
      end

      it 'returns an empty array' do
        expected = {
          roles: []
        }
        subject
        expect(json).to include_json(expected)
      end
    end
  end

  context 'When the user is an admin, return all roles of the account' do
    context 'when role has permissions assigned' do
      let!(:role_permission) { create(:role_permission, role: role2, permission: permission2) }

      it 'resturns a successfull response' do
        subject
        expect(response).to have_http_status(:success)
      end

      it 'returns all roles and permissions' do
        expected = {
          roles: [
            {
              name: role.name,
              permissions_string: ''
            },
            {
              name: role2.name,
              permissions_string: role2.permissions_string
            }
          ]
        }
        subject
        expect(json).to include_json(expected)
      end
    end

    context 'when user doesn\'t have any permissions' do
      it 'returns a successfull response' do
        subject
        expect(response).to have_http_status(:success)
      end

      it 'returns an empty array for both roles' do
        expected = {
          roles: [
            {
              name: role.name,
              permissions_string: ''
            },
            {
              name: role2.name,
              permissions_string: ''
            }
          ]
        }
        subject
        expect(json).to include_json(expected)
      end
    end
  end
end
