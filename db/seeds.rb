AdminUser.create(email: 'admin@example.com', password: 'password') if Rails.env.development?
Setting.create_or_find_by(key: 'min_version', value: '0.0')

# Create all the permissions available
Permission.access_types.keys.each { |key| Permission.find_or_create_by(access_type: key) }

# Creates "admin" role with all the permissions
admin = Role.find_or_create_by(name: "admin")
admin.permissions = Permission.all
admin.save!

# Creates Resource
Resource.find_or_create_by(resource_type: "User", resource_id: nil)
Resource.find_or_create_by(resource_type: "FormCategory", resource_id: nil)
Resource.find_or_create_by(resource_type: "Form", resource_id: nil)
Resource.find_or_create_by(resource_type: "Section", resource_id: nil)
Resource.find_or_create_by(resource_type: "Question", resource_id: nil)
Resource.find_or_create_by(resource_type: "FormQuestion", resource_id: nil)
Resource.find_or_create_by(resource_type: "QuestionOption", resource_id: nil)
Resource.find_or_create_by(resource_type: "Enabler", resource_id: nil)
Resource.find_or_create_by(resource_type: "FormSubmission", resource_id: nil)
Resource.find_or_create_by(resource_type: "Answer", resource_id: nil)
Resource.find_or_create_by(resource_type: "SectionStatus", resource_id: nil)
