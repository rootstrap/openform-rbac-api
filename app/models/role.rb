# == Schema Information
#
# Table name: roles
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string
#  account_id :bigint           not null
#
# Indexes
#
#  index_roles_on_account_id           (account_id)
#  index_roles_on_name_and_account_id  (name,account_id) UNIQUE
#
class Role < ApplicationRecord
  belongs_to :account

  validates :name, uniqueness: { scope: :account_id }
  has_many :assignments, dependent: :destroy
  has_many :users, through: :role_permissions
  has_many :role_permissions, dependent: :destroy
  has_many :permissions, through: :role_permissions

  ADMINS = %w[admin].freeze

  def admin?
    ADMINS.include?(name)
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
