class UserPolicy < ApplicationPolicy
  def permitted_attributes_for_create
    [:external_id, :account_id, roles: %i[id name resource_id resource_type]]
  end

  def permitted_attributes_for_update
    [roles: %i[id name]]
  end
end
