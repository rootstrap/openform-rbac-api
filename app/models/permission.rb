class Permission < ApplicationRecord
  validates :access_type, uniqueness: { scope: :resource_id }

  has_many :role_permissions, dependent: :destroy
  has_many :roles, through: :role_permissions

  belongs_to :resource

  delegate :resource_string, to: :resource

  enum access_type: {
    action_create: 0,
    action_view: 1,
    action_edit: 2,
    action_remove: 3
  }

  def self.permission_strings
    all.map { |permission| [permission.permission_string, permission.id] }
  end

  def permission_string
    "#{access_type}-#{resource_string}"
  end
end
