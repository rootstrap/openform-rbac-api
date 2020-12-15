module Api
  module V1
    class RolesController < ApiController
      def create
        @role = RoleService.new.create!(current_account, permitted_attributes(Role)).decorate
        render :show
      end

      # def update
      # end

      def destroy
        Role.find(params[:id]).destroy!

        head :ok
      end

      def index
        @roles = if current_user&.admin?
                   current_user.roles.decorate.includes(:permissions)
                 else
                   current_account.roles.decorate.includes(:permissions)
                 end
      end

      private

      def role
        @role ||= Role.find(params[:id])
      end
    end
  end
end
