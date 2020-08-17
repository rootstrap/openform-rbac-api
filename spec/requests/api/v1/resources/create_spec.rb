describe 'POST api/v1/resources/', type: :request do
  let(:user)          { create(:user) }
  let(:user_resource) { create(:resource, :user) }
  let(:headers)       { {} }
  subject { post api_v1_resource_path, params: params, headers: headers, as: :json }
  before do
    Permission.access_types.keys.each { |key| Permission.find_or_create_by(access_type: key) }
  end

  describe 'create' do
    let!(:resource) { create(:resource, :user, resource_id: 1) }
    let(:params) { resource }

    describe 'when auth headers are passed' do
      let(:headers) { auth_headers }

      describe 'when user has permission' do
        let!(:admin_role_users) { create(:role, :admin, resource: user_resource, user: user) }

        it 'returns success status code' do
          subject
          expect(response).to have_http_status(:ok)
        end
      end

      describe 'when user does not have permission' do
        it 'returns forbidden status code' do
          subject
          expect(response).to have_http_status(:forbidden)
        end

        it 'returns error message' do
          subject
          expect(json[:error]).to eq('The action on the requested resource is not authorized')
        end
      end
    end

    describe 'when auth headers are missing' do
      it 'returns bad request status code' do
        subject
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns error message' do
        subject
        expect(json[:error]).to eq('A required param is missing')
      end
    end
  end
end
