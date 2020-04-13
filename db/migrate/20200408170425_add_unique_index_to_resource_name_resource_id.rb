class AddUniqueIndexToResourceNameResourceId < ActiveRecord::Migration[6.0]
  def change
    add_index :resources, [:name, :resource_id], unique: true
  end
end
