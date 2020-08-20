class RoleDecorator < ApplicationDecorator
  delegate_all

  def permissions_string
    permissions.map(&:access_type).join(',')
  end
end
