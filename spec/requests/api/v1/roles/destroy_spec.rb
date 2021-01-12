describe 'DELETE api/v1/roles/:id', type: :request do
  let!(:account)        { create(:account) }
  let!(:user)           { create(:user, account: account) }
  let!(:role)           { create(:role, account: account) }
  let!(:role2)           { create(:role, account: account) }
  let(:headers)          { auth_headers }

  subject { delete api_v1_role_path(role_id), headers: headers, as: :json }

  context 'when the role_id exists' do
    let!(:role_id) { role2.id }

    it 'removes the user' do
      expect { subject }.to change { Role.count }.by(-1)
    end
  end

  context 'when the role_id does not exist' do
    let(:role_id) { 'invalid_id' }

    it 'does not change the users count' do
      expect { subject }.not_to change { Role.count }
    end
  end

  context 'when the userId header is not passed' do
    let!(:headers) { {} }
    let!(:role_id) { role.id }

    it 'does not change the user count' do
      expect { subject }.not_to change { Role.count }
    end
  end
end
