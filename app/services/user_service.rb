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
      create_roles!(roles) if roles
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

  def validate_role_name!(role_name)
    return if Role::NAMES.include?(role_name)

    user.errors.add(:roles, I18n.t('api.errors.invalid_role_name'))
    raise ActiveRecord::RecordInvalid, user
  end

  def destroy_roles!
    user.roles.destroy_all
  end

  def create_roles!(roles_hash)
    roles_hash.each do |role|
      role_name = role[:name]
      validate_role_name!(role_name)
      params = {
        resource_id: ResourceService.new(role[:resource_type], role[:resource_id]).resource.id,
        permissions: permissions(role_name)
      }
      user.roles.create!(params)
    end
  end
end
