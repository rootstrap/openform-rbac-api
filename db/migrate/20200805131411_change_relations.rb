class ChangeRelations < ActiveRecord::Migration[6.0]
  def change
    change_table :roles do |t|
      t.belongs_to :user
      t.belongs_to :resource
      t.remove :name
    end

    add_index :permissions, :access_type, unique: true

    drop_table :role_resources do |t|
      t.belongs_to :role
      t.belongs_to :resource

      t.timestamps
    end

    drop_table :user_roles do |t|
      t.belongs_to :user
      t.belongs_to :role

      t.timestamps
    end
  end
end
