describe 'PUT api/v1/users/:external_id', type: :request do
  let!(:account)    { create(:account) }
  let!(:user)       { create(:user, account: account) }
  let!(:role)       { create(:role, account: account) }
  let!(:assignment) { create(:assignment, user: user, role: role) }
  let!(:role2)      { create(:role, account: account) }
  let!(:role3)      { create(:role, account: account) }
  let(:headers)     { auth_headers }
  let(:external_id) { user.external_id }
  let(:params) do
    {
      user: {
        external_id: external_id
      }
    }
  end

  subject { put api_v1_user_path(user.external_id), params: params, headers: headers, as: :json }

  describe 'tries to update the list of roles' do
    context 'without roles params' do
      it 'returns a successfull response' do
        subject
        expect(response).to have_http_status(:success)
      end

      it 'doesnt create a new assignment' do
        expect { subject }.not_to change { Assignment.count }
      end

      it 'returns the updated user' do
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

      it 'creates one assignment' do
        expect { subject }.to change { Assignment.count }.from(1).to(2)
      end

      it 'increases the number of roles of the user' do
        subject
        expect(user.roles.count).to eq(2)
      end

      it 'doesnt assign the wrong role to the user' do
        subject
        expect(user.roles.where(name: role3.name)).to be_empty
      end

      it 'assigns the right role to the user' do
        subject
        expect(user.roles.where(name: role2.name)).not_to be_empty
      end
    end

    context 'with empty roles params' do
      let(:params) do
        {
          user: {
            external_id: external_id,
            roles: []
          }
        }
      end

      it 'deassigns roles from the user' do
        subject
        expect(user.roles.count).to eq(0)
      end

      it 'decreases the assignment count' do
        expect { subject }.to change { Assignment.count }.from(1).to(0)
      end
    end
  end
end
