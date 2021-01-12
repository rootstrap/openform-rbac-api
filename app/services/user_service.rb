class UserService
  attr_accessor :user
  attr_accessor :account

  def initialize(user = User.new, account = nil)
    @user = user
    @account = account
  end

  def create!(account, user_params)
    ActiveRecord::Base.transaction do
      @account = account
      user.assign_attributes(user_params.except(:roles))
      user.account = account
      user.save!
      roles = user_params[:roles]
      assign_roles!(roles) unless roles.nil?

      user
    end
  end

  def update!(user, user_params)
    ActiveRecord::Base.transaction do
      @user = user
      @account = user.account
      user.update!(user_params.except(:roles))
      roles = user_params[:roles]
      unless roles.nil?
        clean_roles!
        assign_roles!(roles)
      end
      user
    end
  end

  private

  def assign_roles!(roles_hash)
    roles_hash.each do |role|
      role_name = role[:name]
      role = @account.roles.where(name: role_name).first
      AssignmentService.new.create!(role, user) unless role.nil?
    end
  end

  def clean_roles!
    Assignment.where(user: user).destroy_all
  end

  def permissions(role_name)
    Permission.send(role_name.to_sym)
  end
end
