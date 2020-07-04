class Resource < ApplicationRecord
  has_many :role_resources, dependent: :destroy
  has_many :roles, through: :role_resources

  validates :resource_type, presence: true,
                            uniqueness: { scope: :resource_id, case_sensitive: false }

  scope :matching, lambda { |params|
                     where(resource_type: params[:resource_type])
                       .where(resource_id: [nil, params[:resource_id]])
                   }

  # example_params = {
  #   resource_type: 'Form',
  #   resource_id: 4,
  #   user_id: 1,
  #   action: Permission.action_view
  # }
  scope :allowed_resources, lambda { |params|
    matching({ resource_type: params[:resource_type], resource_id: params[:resource_id] })
      .includes(roles: %i[permissions users])
      .where(users: { id: params[:user_id] }, permissions: { access_type: params[:action] })
      .references(:users, :roles, :permissions)
  }

  def to_s
    return resource_type.pluralize if resource_id.nil?

    "#{resource_type}; #{resource_id}"
  end
end
