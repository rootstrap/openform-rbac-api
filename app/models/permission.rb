class Permission < ApplicationRecord
  has_many :role_permissions, dependent: :destroy
  has_many :roles, through: :role_permissions

  enum access_type: {
    action_create: 0,
    action_view: 1,
    action_edit: 2,
    action_remove: 3
  }
end
