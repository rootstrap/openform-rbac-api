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
FactoryBot.define do
  factory :permission do
    resource
    access_type { Permission.access_types.values.sample }
  end
end
