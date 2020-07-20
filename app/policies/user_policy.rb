class UserPolicy < ApplicationPolicy
  def create?
    allowed_resource?(Permission.action_create)
  end

  private

  def allowed_resource?(action)
    params = {
      resource_type: 'User',
      resource_id: nil,
      user_id: user.id,
      action: Permission.access_types[action.first.access_type.to_sym]
    }
    Resource.allowed_resources(params).exists?
  end
end
