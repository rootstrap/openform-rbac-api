class CreateRolePermissions < ActiveRecord::Migration[6.0]
  def change
    create_table :role_permissions do |t|
      t.references :role
      t.references :permission

      t.timestamps
    end
  end
end
