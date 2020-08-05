class ResourcePolicy < ApplicationPolicy
  def index?
    show?
  end

  def show?
    allowed_resource?(Permission.access_types[:action_view])
  end

  def create?
    allowed_resource?(Permission.access_types[:action_create])
  end

  def update?
    allowed_resource?(Permission.access_types[:action_edit])
  end

  def destroy?
    allowed_resource?(Permission.access_types[:action_remove])
  end

  private

  def allowed_resource?(action)
    return false unless user

    AllowedResourcesQuery.new(user, user.resources).action_on_resource(action, record).any?
  end
end
