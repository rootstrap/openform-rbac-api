describe UserPolicy do
  subject { described_class }
  let!(:user) { create(:user) }
  let!(:resource) { create(:resource, :user) }

  before do
    Permission.access_types.keys.each { |key| Permission.find_or_create_by(access_type: key) }
  end

  describe 'when user has permissions to create User' do
    let!(:role) { create(:role, :admin, resource: resource, user: user) }

    permissions :create? do
      it 'can create a user' do
        user.reload
        expect(subject).to permit(user, resource)
      end
    end
  end

  describe 'when user does not have permissions to create Users' do
    permissions :create? do
      it 'can create a user' do
        user.reload
        expect(subject).not_to permit(user, resource)
      end
    end
  end
end
