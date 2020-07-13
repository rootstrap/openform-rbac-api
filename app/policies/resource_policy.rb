class ResourcePolicy < ApplicationPolicy
  def index?
    allowed_resource?(Permission.action_view)
  end

  def show?
    allowed_resource?(Permission.action_view)
  end

  def create?
    allowed_resource?(Permission.action_create)
  end

  def update?
    allowed_resource?(Permission.action_edit)
  end

  def destroy?
    allowed_resource?(Permission.action_remove)
  end

  private

  def allowed_resource?(action)
    params = {
      resource_type: @record.resource_type,
      resource_id: @record.resource_id,
      user_id: user.id,
      action: Permission.access_types[action.first.access_type.to_sym]
    }
    Resource.allowed_resources(params).exists?
  end
end
