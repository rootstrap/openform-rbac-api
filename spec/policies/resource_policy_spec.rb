describe ResourcePolicy do
  subject { described_class }
  let(:form_resource)    { create(:resource, :form) }
  let(:user_form_admin)  { create(:user, roles: []) }
  let(:user_form_viewer) { create(:user, roles: []) }
  let!(:role_admin_forms) do
    create(:role, :admin, users: [user_form_admin], resources: [form_resource])
  end
  let!(:role_view_forms) do
    create(:role, :viewer, users: [user_form_viewer], resources: [form_resource])
  end

  describe 'has access' do
    permissions :index?, :show?, :create?, :update?, :destroy? do
      it 'to any form resource' do
        user_form_admin.reload
        expect(subject).to permit(user_form_admin, form_resource)
      end
    end

    permissions :index?, :show? do
      it 'to any form resource' do
        user_form_viewer.reload
        expect(subject).to permit(user_form_viewer, form_resource)
      end
    end
  end

  describe 'does not have access' do
    let(:user_resource) { create(:resource, :user) }
    permissions :index?, :show?, :create?, :update?, :destroy? do
      it 'to any user resource' do
        user_form_admin.reload
        expect(subject).not_to permit(user_form_admin, user_resource)
      end
    end

    permissions :create?, :update?, :destroy? do
      it do
        user_form_viewer.reload
        expect(subject).not_to permit(user_form_viewer, form_resource)
      end
    end
  end
end
