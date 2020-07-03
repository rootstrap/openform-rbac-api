class RoleResource < ApplicationRecord
  belongs_to :role
  belongs_to :resource
end
