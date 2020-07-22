class CreateResources < ActiveRecord::Migration[6.0]
  def change
    create_table :resources do |t|
      t.integer :resource_id
      t.string :resource_type, null: false

      t.timestamps
    end

    create_table :role_resources do |t|
      t.belongs_to :role
      t.belongs_to :resource

      t.timestamps
    end

    add_index :resources, %i[resource_id resource_type], unique: true
  end
end
