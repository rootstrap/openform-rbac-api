FactoryBot.define do
  factory :role do
    name  { Faker::Name.name }
    users { [create(:user, role_ids: [id])] }
    resources { [create(:resource)] }

    trait :admin do
      name { 'admin' }
      permissions do
        Permission.access_types.values.each.map do |access|
          create(:permission, access_type: access)
        end
      end
    end

    trait :viewer do
      name { 'viewer' }
      permissions { [create(:permission, access_type: Permission.access_types[:action_view])] }
    end
  end
end
