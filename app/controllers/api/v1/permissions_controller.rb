module Api
  module V1
    class PermissionsController < ApiController
      def create
        @permission = PermissionService.new.create!(current_account,
                                                    permitted_attributes(Permission))
        render :show
      end

      def index
        @permissions = permission_for_roles(roles).to_a
      end

      # def assign
      # end

      private

      def roles
        role_id = params[:role_id]
        user_id = params[:user_id]

        return_value = if role_id
                         fetch_account(role_id)
                       elsif user_id
                         fetch_user(user_id)
                       elsif admin_current?
                         current_account.roles
                       end

        return_value
      end

      def fetch_account(role_id)
        current_account.roles.where(id: role_id)
      end

      def fetch_user(user_id)
        current_account.users.where(external_id: user_id).first.roles
      end

      def permission_for_roles(roles)
        permissions = RolePermission.where(role: roles)
                                    .includes(permission: :resource)
                                    .collect(&:permission)
                                    .uniq
        permissions
      end

      def admin_current?
        current_user&.admin?
      end
    end
  end
end
