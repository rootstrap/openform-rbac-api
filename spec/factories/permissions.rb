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
FactoryBot.define do
  factory :permission do
    access_type { Permission.access_types.values.sample }
    initialize_with { Permission.find_or_create_by!(access_type: access_type) }
  end
end
