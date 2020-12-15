class RoleDecorator < ApplicationDecorator
  delegate_all

  def permissions_string
    permissions.map(&:to_s).join(',')
  end
end
