class Resource < ApplicationRecord
  has_many :role_resources, dependent: :destroy
  has_many :roles, through: :role_resources

  validates :resource_type, presence: true,
                            uniqueness: { scope: :resource_id, case_sensitive: false }

  def to_s
    return resource_type.pluralize if resource_id.nil?

    "#{resource_type}; #{resource_id}"
  end
end
