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

  def update!(role_params)
    ActiveRecord::Base.transaction do
      role.update!(role_params.except(:roles))

      role
    end
  end
end
