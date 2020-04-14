class RoleDecorator < Draper::Decorator
  delegate_all

  def permissions_string
    permissions.map(&:access_type).join(', ')
  end
end
