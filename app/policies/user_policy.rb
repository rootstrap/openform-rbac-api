class UserPolicy < ApplicationPolicy
  def create?
    action = Permission.access_types[:action_create]

    AllowedResourcesQuery.new(user).allowed_resources(action, User.name).any?
  end
end
