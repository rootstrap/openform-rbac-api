require 'rails_helper'

describe UserService do
  let!(:existing_role) { create(:role, :admin, resource: resources.first) }
  describe '#create!' do
    let(:resources_count) { 5 }
    let!(:resources)      { create_list(:resource, resources_count) }
    let(:user)            { User.new }
    let(:subject)         { UserService.new(user).create!(params) }

    context 'when params are valid' do
      context 'when roles array is passed' do
        let(:params) do
          {
            external_id: 1,
            roles: resources.map do |resource|
              resource.attributes.merge(name: 'admin').with_indifferent_access
            end
          }
        end

        it 'creates the user' do
          expect { subject }.to change { User.count }.by(1)
        end

        it 'creates the roles with the admin permissions' do
          expect { subject }.to change { Role.count }.by(resources_count)
        end

        context 'when the a resource in the role does not exist' do
          let!(:user2) { create(:user) }
          let(:params) do
            {
              external_id: 1,
              roles: [
                {
                  name: 'admin',
                  resource_id: 1,
                  resource_type: 'NonExistantResourceType'
                }.with_indifferent_access
              ]
            }
          end

          it 'changes the resource count' do
            expect { subject }.to change { Resource.count }.by(1)
          end

          it 'creates a resource with the type and id from the params' do
            subject
            new_resource = Resource.last
            expect([new_resource[:resource_id], new_resource[:resource_type]])
              .to eq([1, 'NonExistantResourceType'])
          end
        end
      end

      context 'when roles array is empty' do
        let(:params) do
          {
            external_id: 1,
            roles: []
          }
        end

        it 'creates the user' do
          expect { subject }.to change { User.count }.by(1)
        end

        it 'does not create any roles for the user' do
          expect { subject }.not_to change { Role.count }
        end
      end
    end

    context 'when params are invalid' do
      context 'when the external_id is taken' do
        let!(:user2) { create(:user) }
        let(:params) do
          {
            external_id: user2.external_id,
            roles: resources.map do |resource|
              resource.attributes.merge(name: 'admin').with_indifferent_access
            end
          }
        end

        it 'raises record invalid error' do
          expect { subject }.to raise_error ActiveRecord::RecordInvalid
        end
      end

      context 'when the role name is invalid' do
        let(:user2) { build(:user) }
        let(:params) do
          {
            external_id: user2.external_id,
            roles: resources.map do |resource|
              resource.attributes.merge(name: 'non_existant_role_name').with_indifferent_access
            end
          }
        end

        it 'raises record invalid error' do
          expect { subject }.to raise_error ActiveRecord::RecordInvalid
        end
      end
    end
  end

  describe '#update!' do
    let(:resources_count) { 5 }
    let!(:resources)      { create_list(:resource, resources_count) }
    let(:user)            { create(:user) }
    let(:subject)         { UserService.new(user).update!(params) }

    context 'when params are valid' do
      context 'when the user has resources assigned' do
        let!(:admin_role) do
          create(:role, user: user, permissions: Permission.all, resource: resources.first)
        end
        let(:new_user) { build(:user) }

        context 'when roles array is passed' do
          let(:params) do
            {
              external_id: new_user.external_id,
              roles: resources.map do |resource|
                resource.attributes.merge(name: 'admin').with_indifferent_access
              end
            }
          end

          it 'changes the updated_at timestamp' do
            expect { subject }.to change { user.updated_at }
          end

          it 'changes the external_id attribute' do
            expect { subject }.to change { user.external_id }
          end

          it 'removes the existing role' do
            subject
            expect { admin_role.reload }.to raise_error(ActiveRecord::RecordNotFound)
          end

          it 'creates the new roles' do
            expect { subject }.to change { user.roles.count }.from(1).to(resources_count)
          end

          context 'when the resource in the role does not exist' do
            let!(:user2) { create(:user) }
            let(:params) do
              {
                external_id: 1,
                roles: [
                  {
                    name: 'admin',
                    resource_id: 1,
                    resource_type: 'NonExistantResourceType'
                  }.with_indifferent_access
                ]
              }
            end

            it 'changes the resource count' do
              expect { subject }.to change { Resource.count }.by(1)
            end

            it 'creates a resource with the type and id from the params' do
              subject
              new_resource = Resource.last
              expect([new_resource[:resource_id], new_resource[:resource_type]])
                .to eq([1, 'NonExistantResourceType'])
            end
          end
        end

        context 'when roles array is empty' do
          let(:params) do
            {
              external_id: 1,
              roles: []
            }
          end

          it 'changes the updated_at timestamp' do
            expect { subject }.to change { user.updated_at }
          end

          it 'changes the external_id attribute' do
            expect { subject }.to change { user.external_id }
          end

          it 'removes the roles for the user' do
            expect { subject }.to change { user.roles.count }.from(1).to(0)
          end
        end
      end
    end

    context 'when params are invalid' do
      context 'when the external_id is taken' do
        let!(:user2) { create(:user) }
        let(:params) do
          {
            external_id: user2.external_id,
            roles: resources.map do |resource|
              resource.attributes.merge(name: 'admin').with_indifferent_access
            end
          }
        end

        it 'raises record invalid error' do
          expect { subject }.to raise_error ActiveRecord::RecordInvalid
        end
      end

      context 'when the role name is invalid' do
        let(:user2) { build(:user) }
        let(:params) do
          {
            external_id: user2.external_id,
            roles: resources.map do |resource|
              resource.attributes.merge(name: 'non_existant_role_name').with_indifferent_access
            end
          }
        end

        it 'raises record invalid error' do
          expect { subject }.to raise_error ActiveRecord::RecordInvalid
        end
      end
    end
  end
end
