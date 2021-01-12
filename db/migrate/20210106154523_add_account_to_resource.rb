class AddAccountToResource < ActiveRecord::Migration[6.0]
  def change
  	add_reference :resources, :account, foreign_key: true
  end
end
