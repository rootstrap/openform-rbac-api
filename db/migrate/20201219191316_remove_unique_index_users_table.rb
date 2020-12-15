class RemoveUniqueIndexUsersTable < ActiveRecord::Migration[6.0]
  def change
    remove_index :users, :external_id
    add_index :users, [:external_id, :account_id], unique: true
  end
end
