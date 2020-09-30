# == Schema Information
#
# Table name: roles
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint
#  resource_id :bigint
#
# Indexes
#
#  index_roles_on_resource_id  (resource_id)
#  index_roles_on_user_id      (user_id)
#
class Role < ApplicationRecord
  NAMES = %w[admin viewer].freeze

  belongs_to :user
  belongs_to :resource

  has_many :role_permissions, dependent: :destroy
  has_many :permissions, through: :role_permissions

  def name
    case permissions.pluck(:access_type)
    when admin_permissions
      'admin'
    when view_permissions
      'viewer'
    when create_permissions
      'creator'
    end
  end

  private

  def admin_permissions
    Permission.access_types.keys
  end

  def view_permissions
    ['action_view']
  end

  def create_permissions
    %w[action_create action_view]
  end
end
