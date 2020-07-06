class Role < ApplicationRecord
  validates :name, presence: true

  has_many :user_roles, dependent: :destroy
  has_many :users, through: :user_roles

  has_many :role_permissions, dependent: :destroy
  has_many :permissions, through: :role_permissions

  has_many :role_resources, dependent: :destroy
  has_many :resources, through: :role_resources
end
