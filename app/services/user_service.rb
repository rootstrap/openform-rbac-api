class UserService
  attr_accessor :user

  def initialize(user = User.new)
    @user = user
  end

  def create!(user_params)
    ActiveRecord::Base.transaction do
      user.assign_attributes(user_params.except(:roles))
      user.save!
      roles = user_params[:roles]
      if roles
        destroy_roles!
        create_roles!(roles)
      end
      user
    end
  end

  def update!(user_params)
    ActiveRecord::Base.transaction do
      user.update!(user_params.except(:roles))
      roles = user_params[:roles]
      if roles
        destroy_roles!
        create_roles!(roles)
      end
      user
    end
  end

  private

  def permissions(role_name)
    Permission.send(role_name.to_sym)
  end

  def destroy_roles!
    user.roles.each(&:destroy!)
  end

  def create_roles!(roles_hash)
    roles_hash.each do |role|
      params = {
        resource_id: ResourceService.new(role[:resource_type], role[:resource_id]).resource.id,
        permissions: permissions(role[:name])
      }
      user.roles.create!(params)
    end
  end
end
