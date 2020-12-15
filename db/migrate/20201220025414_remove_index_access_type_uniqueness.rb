class RemoveIndexAccessTypeUniqueness < ActiveRecord::Migration[6.0]
  def change
    remove_index :permissions, :access_type
    add_index :permissions, [:access_type, :resource_id], unique: true
  end
end
