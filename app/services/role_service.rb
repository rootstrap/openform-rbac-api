class RoleService
  attr_accessor :role

  def initialize(role = Role.new)
    @role = role
  end

  def create!(account, role_params)
    ActiveRecord::Base.transaction do
      role.assign_attributes(role_params)
      role.account = account
      role.save!
      role
    end
  end

  def assign_permissions!(role, permission_ids)
    ActiveRecord::Base.transaction do
      permission_ids.each do |permission_id|
        RolePermission.create_or_find_by(role_id: role.id, permission_id: permission_id)
      end
    end
  end

  def unassign_permissions!(role, permission_ids)
    ActiveRecord::Base.transaction do
      permission_ids.each do |permission_id|
        RolePermission.where(role_id: role.id, permission_id: permission_id).destroy_all
      end
    end
  end

  def update!(role_params)
    ActiveRecord::Base.transaction do
      role.update!(role_params.except(:roles))

      role
    end
  end
end
