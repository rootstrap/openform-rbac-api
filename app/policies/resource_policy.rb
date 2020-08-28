class ResourcePolicy < ApplicationPolicy
  def index?
    show?
  end

  def show?
    allowed_resource?(Permission.access_types[:action_view])
  end

  def create?
    allowed_resource?(Permission.access_types[:action_create])
  end

  def update?
    allowed_resource?(Permission.access_types[:action_edit])
  end

  def destroy?
    allowed_resource?(Permission.access_types[:action_remove])
  end

  private

  def allowed_resource?(actions)
    return false unless user

    ResourceService.new(record.resource_type, record.resource_id)
                   .action_on_resource?(user, actions)
  end
end
