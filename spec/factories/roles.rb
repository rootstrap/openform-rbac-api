FactoryBot.define do
  factory :role do
    name  { Faker::Name.name }
    users { [create(:user, role_ids: [id])] }
  end
end
