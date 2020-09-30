describe 'DELETE api/v1/users/:id', type: :request do
  let!(:user)            { create(:user, resources: []) }
  let!(:user2)           { create(:user, resources: []) }
  let!(:user_resource)   { create(:resource, :user) }
  let!(:form_resource)   { create(:resource, :form) }
  let!(:admin_user_role) { create(:role, :admin, resource: user_resource, user: user) }
  let(:headers)          { auth_headers }
  subject { delete api_v1_user_path(user_id), headers: headers, as: :json }
  before do
    Permission.access_types.keys.each { |key| Permission.find_or_create_by(access_type: key) }
    user.reload
  end

  context 'when the user_id exists' do
    let!(:admin_form_role) { create(:role, :admin, resource: form_resource, user: user2) }
    let!(:admin_user_role) { create(:role, :admin, resource: user_resource, user: user2) }
    let!(:user_id) { user2.external_id }

    it 'removes the roles for the user existing roles' do
      expect { subject }.to change { Role.count }.by(-2)
    end

    it 'removes the role_permissions for the roles' do
      expect { subject }.to change { RolePermission.count }.by(-8)
    end

    it 'removes the user' do
      expect { subject }.to change { User.count }.by(-1)
    end
  end

  context 'when the user_id does not exist' do
    let!(:admin_form_role) { create(:role, :admin, resource: form_resource, user: user2) }
    let!(:admin_user_role) { create(:role, :admin, resource: user_resource, user: user2) }
    let(:user_id) { 'invalid_id' }

    it 'does not change the roles count' do
      expect { subject }.not_to change { Role.count }
    end

    it 'does not change the role_permissions count' do
      expect { subject }.not_to change { RolePermission.count }
    end

    it 'does not change the users count' do
      expect { subject }.not_to change { User.count }
    end
  end

  context 'when the userId header is not passed' do
    let!(:headers) { {} }
    let!(:user_id) { user2.external_id }

    it 'does not change the user count' do
      expect { subject }.not_to change { User.count }
    end
  end
end
