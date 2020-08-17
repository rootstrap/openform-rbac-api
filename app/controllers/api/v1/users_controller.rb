module Api
  module V1
    class UsersController < Api::V1::ApiController
      def create
        authorize User
        @user = User.create!(user_params)
        render :show
      end

      private

      def user_params
        params.require(:user).permit(:external_id)
      end
    end
  end
end
