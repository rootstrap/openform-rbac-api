class AddUniqueIndexToPermissionTypeResourceId < ActiveRecord::Migration[6.0]
  def change
    add_index :permissions, [:access_type, :resource_id], unique: true
  end
end
