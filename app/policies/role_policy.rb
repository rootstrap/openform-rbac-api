class RolePolicy < ApplicationPolicy
  def permitted_attributes_for_create
    %i[name account_id]
  end

  def permitted_attributes_for_assign
    %i[permission_ids]
  end

  def permitted_attributes_for_unassign
    %i[permission_ids]
  end
end
