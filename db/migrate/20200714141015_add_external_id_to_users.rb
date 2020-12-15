class AddExternalIdToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :external_id, :integer

    add_index :users, :external_id, unique: true
  end
end
