# == Schema Information
#
# Table name: resources
#
#  id            :bigint           not null, primary key
#  resource_id   :integer
#  resource_type :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  account_id    :bigint
#
# Indexes
#
#  index_resources_on_account_id                                    (account_id)
#  index_resources_on_account_id_and_resource_id_and_resource_type
#  (account_id,resource_id,resource_type) UNIQUE
#
class Resource < ApplicationRecord
  belongs_to :account
  has_many :role_permissions, dependent: :destroy
  has_many :roles, through: :role_permissions

  validates :account_id, presence: true
  validates :resource_type, presence: true
  validates :resource_id, presence: true
  validates :resource_id, uniqueness: { scope: %i[account_id resource_type] }

  def to_s
    return resource_type.pluralize if resource_id.nil?

    "#{resource_type}; #{resource_id}"
  end
end
