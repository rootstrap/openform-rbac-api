module Api
  module V1
    class UsersController < ApiController
      helper_method :user

      def create
        @user = UserService.new.create!(current_account, permitted_attributes(User))
        render :show
      end

      def update
        @user = UserService.new.update!(user, permitted_attributes(User))
        render :show
      end

      def destroy
        user&.destroy!

        head :ok
      end

      private

      def user
        @user ||= User.where(external_id: params[:id], account: current_account).first
      end
    end
  end
end
