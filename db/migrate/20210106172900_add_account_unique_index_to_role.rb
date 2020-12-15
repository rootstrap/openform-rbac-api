class AddAccountUniqueIndexToRole < ActiveRecord::Migration[6.0]
  def change
  	add_index :roles, [:name, :account_id], unique: true
  end
end
