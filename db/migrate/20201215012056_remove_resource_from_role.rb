class RemoveResourceFromRole < ActiveRecord::Migration[6.0]
  def change
  	remove_column :roles, :resource_id
  end
end
