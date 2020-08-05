AdminUser.create!(email: 'admin@example.com', password: 'password') if Rails.env.development?
Setting.create_or_find_by!(key: 'min_version', value: '0.0')

# Create all the permissions available
Permission.access_types.keys.each { |key| Permission.find_or_create_by(access_type: key) }

# Creates Resource
%w[User FormCategory Form Section Question FormQuestion QuestionOption Enabler
   FormSubmission Answer SectionStatus].each do |model|
  Resource.find_or_create_by(resource_type: model, resource_id: nil)
end
