describe 'DELETE api/v1/users/:id', type: :request do
  let!(:account) { create(:account) }
  let!(:user)    { create(:user, account: account) }
  let!(:user2)   { create(:user, account: account) }
  let(:headers)  { auth_headers }

  subject { delete api_v1_user_path(user_id), headers: headers, as: :json }

  context 'when the user_id exists' do
    let!(:user_id) { user2.external_id }

    it 'removes the user' do
      expect { subject }.to change { User.count }.by(-1)
    end
  end

  context 'when the user_id does not exist' do
    let(:user_id) { 'invalid_id' }

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
