class CreateResources < ActiveRecord::Migration[6.0]
  def change
    create_table :resources do |t|
      t.string :name, null: false
      t.integer :resource_id, null: true

      t.timestamps
    end
  end
end
