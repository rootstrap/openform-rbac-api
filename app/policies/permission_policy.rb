class PermissionPolicy < ApplicationPolicy
  def permitted_attributes_for_create
    [:access_type, resource: %i[resource_id resource_type]]
  end
end
