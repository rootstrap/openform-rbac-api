class UserPolicy < ApplicationPolicy
  def create?
    resource = Resource.find_or_create_by!(resource_type: User.name, resource_id: nil)
    action = Permission.access_types[:action_create]

    AllowedResourcesQuery.new(user, user.resources).action_on_resource(action, resource).any?
  end
end
