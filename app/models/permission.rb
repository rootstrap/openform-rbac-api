# == Schema Information
#
# Table name: permissions
#
#  id          :bigint           not null, primary key
#  access_type :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  resource_id :bigint
#
# Indexes
#
#  index_permissions_on_access_type_and_resource_id  (access_type,resource_id) UNIQUE
#  index_permissions_on_resource_id                  (resource_id)
#
class Permission < ApplicationRecord
  enum access_type: {
    action_create: 0,
    action_view: 1,
    action_edit: 2,
    action_remove: 3
  }

  belongs_to :resource
  validates :access_type, presence: true
  has_many :role_permissions, dependent: :destroy
  has_many :roles, through: :role_permissions

  def to_s
    "#{access_type}|#{resource}"
  end

  scope :admin, -> { where(access_type: access_types.values) }
  scope :viewer, -> { action_view }
end
