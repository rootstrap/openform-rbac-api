# == Schema Information
#
# Table name: users
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  external_id :integer          not null
#
# Indexes
#
#  index_users_on_external_id  (external_id) UNIQUE
#

class User < ApplicationRecord
  has_many :roles, dependent: :destroy
  has_many :resources, through: :roles

  validates :external_id, uniqueness: true, presence: true
end
