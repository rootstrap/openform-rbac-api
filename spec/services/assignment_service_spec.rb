require 'rails_helper'

describe AssignmentService do
  let!(:account)    { create(:account) }
  let!(:user)       { create(:user, account: account) }
  let(:headers)     { auth_headers }
  let!(:role)       { create(:role, account: account) }
  let!(:assignment) { create(:assignment, user: user, role: role) }
  let!(:role2)      { create(:role, account: account) }

  describe '#create!' do
    let(:subject)     { AssignmentService.new.create!(role2, user) }

    context 'when a new assignment is created' do
      it 'creates the assignment' do
        expect { subject }.to change { Assignment.count }.by(1)
      end
    end
  end
end
