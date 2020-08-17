# == Schema Information
#
# Table name: roles
#
#  id          :bigint           not null, primary key
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint
#  resource_id :bigint
#
# Indexes
#
#  index_roles_on_resource_id  (resource_id)
#  index_roles_on_user_id      (user_id)
#
FactoryBot.define do
  factory :role do
    user
    resource

    trait :admin do
      permissions do
        Permission.access_types.values.each.map do |access|
          create(:permission, access_type: access)
        end
      end
    end

    trait :viewer do
      permissions { [create(:permission, access_type: Permission.access_types[:action_view])] }
    end
  end
end
