describe 'POST api/v1/permissions/', type: :request do
  let!(:account)        { create(:account) }
  let!(:user)           { create(:user, account: account) }
  let(:headers)        { auth_headers }
  let(:params)         do
    {
      permission: {
        access_type: Permission.access_types.values.sample,
        resource: { resource_id: 1, resource_type: 'form' }.with_indifferent_access
      }
    }
  end

  subject { post api_v1_permissions_path, params: params, headers: headers, as: :json }

  describe 'with an non-existing resource' do
    it 'returns a successfull response' do
      subject
      expect(response).to have_http_status(:success)
    end

    it 'should create a permission' do
      expect { subject }.to(change { Permission.count })
    end

    it 'should create a resource' do
      expect { subject }.to(change { Resource.count })
    end
  end

  describe 'with an existing resource' do
    let!(:resource) { create(:resource, account: account) }
    let(:params) do
      {
        permission: {
          access_type: Permission.access_types.values.sample,
          resource: { resource_id: resource.resource_id,
                      resource_type: resource.resource_type }.with_indifferent_access
        }
      }
    end
    it 'returns a successfull response' do
      subject
      expect(response).to have_http_status(:success)
    end

    it 'should create a permission' do
      expect { subject }.to(change { Permission.count })
    end

    it 'should not create a rosource' do
      expect { subject }.not_to(change { Resource.count })
    end
  end
end
