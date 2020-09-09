class ResourcePolicy < ApplicationPolicy
  def index?
    super || show?
  end

  def show?
    super || allowed_resource?(Permission.access_types[:action_view])
  end

  def create?
    super || allowed_resource?(Permission.access_types[:action_create])
  end

  def update?
    super || allowed_resource?(Permission.access_types[:action_edit])
  end

  def destroy?
    super || allowed_resource?(Permission.access_types[:action_remove])
  end

  private

  def allowed_resource?(actions)
    return false unless user

    ResourceService.new(record.resource_type, record.resource_id)
                   .action_on_resource?(user, actions)
  end
end
