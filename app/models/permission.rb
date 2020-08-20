# == Schema Information
#
# Table name: permissions
#
#  id          :bigint           not null, primary key
#  access_type :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_permissions_on_access_type  (access_type) UNIQUE
#
class Permission < ApplicationRecord
  enum access_type: {
    action_create: 0,
    action_view: 1,
    action_edit: 2,
    action_remove: 3
  }

  has_many :role_permissions, dependent: :destroy
  has_many :roles, through: :role_permissions

  validates :access_type, uniqueness: true

  delegate :to_s, to: :access_type
end
