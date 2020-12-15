class RolePolicy < ApplicationPolicy
  def permitted_attributes_for_create
    %i[name account_id]
  end
end
