class AddResourceToPermission < ActiveRecord::Migration[6.0]
  def change
  	add_reference :permissions, :resource, foreign_key: true
  end
end
