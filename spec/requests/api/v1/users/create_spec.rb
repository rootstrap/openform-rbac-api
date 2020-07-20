describe 'POST api/v1/users/', type: :request do
  let(:user)          { create(:user) }
  let(:user_resource) { create(:resource, :user) }
  let(:external_id)   { user.external_id + 1 }
  let(:headers)       { auth_headers }
  let!(:params) do
    {
      user: {
        external_id: external_id
      }
    }
  end
  subject { post api_v1_users_path, params: params, headers: headers, as: :json }
  before do
    Permission.access_types.keys.each { |key| Permission.find_or_create_by(access_type: key) }
  end

  context 'when user has user creation permissions' do
    let!(:admin_user_role) { create(:role, :admin, resources: [user_resource], users: [user]) }

    before do
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
  end

  context 'when user doesn\'t have user creation permissions' do
    it 'resturns a forbidden response' do
      subject
      expect(response).to have_http_status(:forbidden)
    end

    it 'does not create the user' do
      expect { subject }.not_to change { User.count }
    end

    it 'returns an error message' do
      subject
      expect(json[:error]).to eq('The action on the requested resource is not authorized')
    end
  end
end
