module Api
  module V1
    class ResourcesController < Api::V1::ApiController
      before_action :authorize_requested_resource

      def create
        head :ok
      end

      def index
        head :ok
      end

      def show
        head :ok
      end

      def update
        head :ok
      end

      def destroy
        head :ok
      end

      private

      def resource_params
        params.require(:resource).permit(:resource_id, :resource_type)
      end

      def authorize_requested_resource
        authorize ResourceService.new(resource_params[:resource_type],
                                      resource_params[:resource_id])
                                 .resource
      end

      def pundit_user
        current_user
      end
    end
  end
end
