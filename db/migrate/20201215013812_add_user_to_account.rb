class AddUserToAccount < ActiveRecord::Migration[6.0]
  def change
  	add_reference :users, :account, foreign_key: true
  end
end
