class AddResourceToPermission < ActiveRecord::Migration[6.0]
  def change
    add_reference :permissions, :resource, null: false
  end
end
