describe 'POST api/v1/users/', type: :request do
  let(:user)           { create(:user, resources: []) }
  let!(:user_resource) { create(:resource, :user) }
  let(:headers)        { auth_headers }
  let(:external_id)    { user.external_id + 1 }
  let(:params)         do
    {
      user: {
        external_id: external_id
      }
    }
  end
  let!(:admin_user_role) { create(:role, :admin, resource: user_resource, user: user) }
  subject { post api_v1_users_path, params: params, headers: headers, as: :json }
  before do
    Permission.access_types.keys.each { |key| Permission.find_or_create_by(access_type: key) }
    user.reload
  end

  describe 'with repeated external_id' do
    let!(:external_id) { user.external_id }

    it 'does not create a user' do
      expect { subject }.not_to(change { User.count })
    end

    it 'returns bad request status' do
      subject
      expect(response).to have_http_status(:bad_request)
    end
  end

  describe 'with valid external_id' do
    context 'without roles params' do
      it 'resturns a successfull response' do
        subject
        expect(response).to have_http_status(:success)
      end

      it 'creates the user' do
        expect { subject }.to change { User.count }.from(1).to(2)
      end

      it 'returns the created user' do
        subject
        expect(json[:user][:external_id]).to eq(external_id)
      end
    end

    context 'with roles params' do
      let(:params) do
        {
          user: {
            external_id: external_id,
            roles: [
              resource_id: '1',
              resource_type: 'Form',
              name: 'admin'
            ]
          }
        }
      end

      it 'creates the user' do
        expect { subject }.to change { User.count }.from(1).to(2)
      end

      it 'assigns the form to the new user' do
        subject
        new_user = User.find_by(external_id: external_id)
        added_resource = new_user.roles.last.resource
        expect([added_resource.resource_id, added_resource.resource_type]).to eq([1, 'Form'])
      end

      it 'has only one role' do
        subject
        new_user = User.find_by(external_id: external_id)
        expect(new_user.roles.count).to eq(1)
      end

      it 'creates a role with the admin permissions' do
        subject
        new_user = User.find_by(external_id: external_id)
        created_role = new_user.roles.last
        expect(created_role.permissions.pluck(:access_type).sort).to eq(Permission.access_types
          .keys.sort)
      end
    end
  end
end
