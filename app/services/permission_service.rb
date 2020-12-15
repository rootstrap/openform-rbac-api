class PermissionService
  attr_accessor :permission

  def initialize(permission = Permission.new)
    @permission = permission
  end

  def create!(account, permission_params)
    ActiveRecord::Base.transaction do
      permission.assign_attributes(permission_params.except(:resource))
      resource_hash = permission_params[:resource]
      resource = ResourceService.new.find_or_create_by!(account,
                                                        resource_hash[:resource_type],
                                                        resource_hash[:resource_id])
      permission.resource = resource
      permission.save!
      permission
    end
  end

  def update!(permission_params)
    ActiveRecord::Base.transaction do
      permission.update!(permission_params.except(:permissions))

      permission
    end
  end
end
