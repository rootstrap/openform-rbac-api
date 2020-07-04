module Api
  module V1
    class ResourcesController < Api::V1::ApiController
      def index
        authorize requested_resource
        head :ok
      end

      def show
        authorize requested_resource
        head :ok
      end

      def update
        authorize requested_resource
        head :ok
      end

      def destroy
        authorize requested_resource
        head :ok
      end

      private

      def resource_params
        params.require(:resource).permit(:resource_id, :resource_type)
      end

      def requested_resource
        @requested_resource ||= Resource.matching(resource_id: resource_params[:resource_id],
                                                  resource_type: resource_params[:resource_type])
                                        .first
      end
    end
  end
end
