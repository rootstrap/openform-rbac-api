# == Schema Information
#
# Table name: users
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  external_id :integer
#  account_id  :bigint
#
# Indexes
#
#  index_users_on_account_id                  (account_id)
#  index_users_on_external_id_and_account_id  (external_id,account_id) UNIQUE
#

class User < ApplicationRecord
  belongs_to :account
  has_many :assignments, dependent: :destroy
  has_many :roles, through: :assignments

  validates :external_id, presence: true, uniqueness: { scope: :account_id }

  def admin?
    roles.where(name: Role::ADMINS).present?
  end
end
