class AddRolePermissionUniquenessIndex < ActiveRecord::Migration[6.0]
  def change
  	add_index :role_permissions, [:role_id, :permission_id], unique: true
  end
end
