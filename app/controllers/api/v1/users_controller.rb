module Api
  module V1
    class UsersController < Api::V1::ApiController
      before_action :auth_user

      def create
        @user = User.create! user_params
        render :show
      end

      private

      def auth_user
        authorize current_user
      end

      def user_params
        params.require(:user).permit(:external_id)
      end
    end
  end
end
