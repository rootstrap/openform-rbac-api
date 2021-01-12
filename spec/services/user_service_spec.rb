require 'rails_helper'

describe UserService do
  let!(:account)    { create(:account) }
  let!(:admin_user) { create(:user, account: account) }
  let(:headers)     { auth_headers }

  describe '#create!' do
    let(:roles_count) { 5 }
    let!(:roles)      { create_list(:role, roles_count, account: account) }
    let(:subject)     { UserService.new.create!(account, params) }

    context 'when params are valid' do
      context 'when roles array is passed' do
        let(:params) do
          {
            external_id: 14,
            roles: roles.as_json(only: :name)
          }.with_indifferent_access
        end

        it 'creates the user' do
          expect { subject }.to change { User.count }.by(1)
        end

        it 'creates the assignment to roles' do
          expect { subject }.to change { Assignment.count }.by(roles_count)
        end

        context 'when the role exists' do
          let!(:user2) { create(:user) }
          let(:params) do
            {
              external_id: 1,
              roles: [
                {
                  name: roles.first.name
                }.with_indifferent_access
              ]
            }
          end

          it 'changes the assignment count' do
            expect { subject }.to change { Assignment.count }.by(1)
          end
        end
        context 'when the role doesnt exist' do
          let!(:user2) { create(:user) }
          let(:params) do
            {
              external_id: 1,
              roles: [
                {
                  name: 'non_existant_role_name'
                }.with_indifferent_access
              ]
            }
          end

          it 'changes the resource count' do
            expect { subject }.not_to change { Assignment.count }
          end
        end
      end

      context 'when roles array is empty' do
        let(:params) do
          {
            external_id: 142,
            roles: []
          }
        end

        it 'creates the user' do
          expect { subject }.to change { User.count }.by(1)
        end

        it 'does not create any roles for the user' do
          expect { subject }.not_to change { Assignment.count }
        end
      end
    end

    context 'when params are invalid' do
      context 'when the external_id is taken' do
        let!(:user2) { create(:user, account: account) }
        let(:params) do
          {
            external_id: user2.external_id,
            roles: roles.as_json(only: :name)
          }.with_indifferent_access
        end

        it 'raises record invalid error' do
          expect { subject }.to raise_error ActiveRecord::RecordInvalid
        end
      end
    end
  end
end
