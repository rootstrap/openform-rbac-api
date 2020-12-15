describe 'POST api/v1/users/', type: :request do
  let!(:account)    { create(:account) }
  let!(:user)       { create(:user, account: account) }
  let!(:role)       { create(:role, account: account) }
  let!(:role2)      { create(:role, account: account) }
  let!(:role3)      { create(:role, account: account) }
  let(:headers)     { auth_headers }
  let(:external_id) { user.external_id + 1 }
  let(:params) do
    {
      user: {
        external_id: external_id
      }
    }
  end

  subject { post api_v1_users_path, params: params, headers: headers, as: :json }

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
            roles: [{ name: role.name }, { name: role2.name }]
          }
        }
      end

      it 'creates the user' do
        expect { subject }.to change { User.count }.from(1).to(2)
      end

      it 'assigns the roles to the user' do
        subject
        new_user = account.users.where(external_id: external_id).first
        expect(new_user.roles.count).to eq(2)
      end

      it 'doesnt assign the wrong role to the user' do
        subject
        new_user = account.users.where(external_id: external_id).first
        expect(new_user.roles.where(name: role3.name)).to be_empty
      end

      it 'doesnt assigns the right role to the user' do
        subject
        new_user = account.users.where(external_id: external_id).first
        expect(new_user.roles.where(name: role2.name)).not_to be_empty
      end
    end
  end
end
