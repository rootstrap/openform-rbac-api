class Resource < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: { scope: :resource_id }

  has_many :permissions, dependent: :destroy

  def self.resource_strings
    all.map { |resource| [resource.resource_string, resource.id] }
  end

  def resource_string
    resource_identifier = "-#{resource_id}" if resource_id
    "#{name}#{resource_identifier}"
  end
end
