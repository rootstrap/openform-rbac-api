# == Schema Information
#
# Table name: resources
#
#  id            :bigint           not null, primary key
#  resource_id   :integer
#  resource_type :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_resources_on_resource_id_and_resource_type  (resource_id,resource_type) UNIQUE
#
class Resource < ApplicationRecord
  has_many :roles, dependent: :destroy
  has_many :users, through: :roles

  validates :resource_type, presence: true,
                            uniqueness: { scope: :resource_id, case_sensitive: false }

  scope :matching, lambda { |params|
                     where(resource_type: params[:resource_type])
                       .where(resource_id: [nil, params[:resource_id]])
                       .order(resource_id: :asc)
                   }

  def to_s
    return resource_type.pluralize if resource_id.nil?

    "#{resource_type}; #{resource_id}"
  end
end
