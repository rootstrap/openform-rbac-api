module Api
  module V1
    module Users
      class RolesController < ApiController
        def index
          @roles = current_user.roles.includes(:permissions, :resource).decorate
          filter = params[:filter]
          return @roles if filter.blank?

          @roles = @roles.where(resources: { resource_type: filter })
        end
      end
    end
  end
end
