class AssignmentService
  attr_accessor :role
  attr_accessor :user

  def initialize(role = Role.new, user = User.new)
    @role = role
    @user = user
  end

  def create!(role, user)
    Assignment.find_or_create_by(role: role, user: user)
  end

  def destroy!(assignment_params)
    ActiveRecord::Base.transaction do
      assignment.where(assignment_params).destroy!
    end
  end
end
