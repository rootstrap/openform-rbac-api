class CreatePermissions < ActiveRecord::Migration[6.0]
  def change
    create_table :permissions do |t|
      t.integer :access_type, null: false

      t.timestamps
    end
  end
end
