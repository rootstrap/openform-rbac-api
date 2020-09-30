module Api
  module V1
    class UsersController < ApiController
      helper_method :user

      def create
        @user = UserService.new.create!(permitted_attributes(User))
        render :show
      end

      def update
        UserService.new(user).update!(permitted_attributes(user))
        render :show
      end

      def destroy
        User.includes(roles: [:role_permissions]).find_by!(external_id: params[:id]).destroy!

        head :ok
      end

      private

      def user
        @user ||= User.find_by!(external_id: params[:id])
      end
    end
  end
end
