# == Schema Information
#
# Table name: role_permissions
#
#  id            :bigint           not null, primary key
#  role_id       :bigint
#  permission_id :bigint
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_role_permissions_on_permission_id              (permission_id)
#  index_role_permissions_on_role_id                    (role_id)
#  index_role_permissions_on_role_id_and_permission_id  (role_id,permission_id) UNIQUE
#

FactoryBot.define do
  factory :role_permission do
    role
    permission
  end
end
