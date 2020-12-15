describe 'POST api/v1/roles/', type: :request do
  let!(:account)  { create(:account) }
  let!(:user)     { create(:user, account: account) }
  let!(:role)     { create(:role, account: account) }
  let(:headers)   { auth_headers }
  let(:role_name) { Faker::Lorem.word }
  let(:params) do
    {
      role: {
        name: role_name
      }
    }
  end

  subject { post api_v1_roles_path, params: params, headers: headers, as: :json }

  describe 'with repeated name' do
    let!(:role_name) { role.name }

    it 'does not create a role' do
      expect { subject }.not_to(change { Role.count })
    end

    it 'returns bad request status' do
      subject
      expect(response).to have_http_status(:bad_request)
    end
  end

  describe 'with valid name' do
    it 'returns a successfull response' do
      subject
      expect(response).to have_http_status(:success)
    end

    it 'creates the role' do
      expect { subject }.to change { Role.count }.from(1).to(2)
    end

    it 'returns the created role' do
      subject
      expect(json[:role][:name]).to eq(role_name)
    end
  end
end
