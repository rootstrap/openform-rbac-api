class AddAccountToRoles < ActiveRecord::Migration[6.0]
  def change
    add_reference :roles, :account, null: false, foreign_key: true
  end
end
