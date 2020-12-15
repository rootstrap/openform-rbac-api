class ChangeUniqueIndexResource < ActiveRecord::Migration[6.0]
  def change
  	remove_index :resources, [:resource_id, :resource_type]
    add_index :resources, [:account_id, :resource_id, :resource_type], unique: true
  end
end
