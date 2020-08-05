module Api
  module V1
    module Users
      class ResourcesController < ApiController
        def index
          @resources = current_user.resources.includes(roles: [:permissions])
          @resources = @resources.filter_by_type(params[:filter]) if params[:filter]
        end
      end
    end
  end
end
