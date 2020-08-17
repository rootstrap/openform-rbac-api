describe 'GET api/v1/user/roles', type: :request do
  let(:user)           { create(:user, resources: []) }
  let!(:form_resource) { create(:resource, :form) }
  let!(:user_resource) { create(:resource, :user) }
  let(:headers)        { auth_headers }
  let(:params)         { {} }
  subject { get api_v1_user_roles_path, params: params, headers: headers, as: :json }
  before do
    Permission.access_types.keys.each { |key| Permission.find_or_create_by(access_type: key) }
  end

  context 'when user has resources assigned' do
    let!(:admin_form_role) { create(:role, :admin, resource: form_resource, user: user) }
    let!(:admin_user_role) { create(:role, :admin, resource: user_resource, user: user) }

    it 'resturns a successfull response' do
      subject
      expect(response).to have_http_status(:success)
    end

    it 'returns only the the form resource' do
      expected = {
        roles: [
          {
            name: 'admin',
            resource: {
              resource_id: admin_form_role.resource.resource_id,
              resource_type: admin_form_role.resource.resource_type
            }
          },
          {
            name: 'admin',
            resource: {
              resource_id: admin_user_role.resource.resource_id,
              resource_type: admin_user_role.resource.resource_type
            }
          }
        ]
      }
      subject
      expect(json).to include_json(expected)
    end
  end

  context 'when user doesn\'t have any resource assigned' do
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

  context 'when a filter is passed' do
    let!(:admin_form_role) { create(:role, :admin, resource: form_resource, user: user) }
    let!(:admin_user_role) { create(:role, :admin, resource: user_resource, user: user) }
    let!(:params)          { { filter: 'User' } }

    it 'returns a successfull response' do
      subject
      expect(response).to have_http_status(:success)
    end

    it 'returns an array containing only the filtered resource' do
      expected = {
        roles: [
          {
            name: 'admin',
            resource: {
              resource_id: admin_user_role.resource.resource_id,
              resource_type: admin_user_role.resource.resource_type
            }
          }
        ]
      }
      subject
      expect(json).to include_json(expected)
    end
  end
end
