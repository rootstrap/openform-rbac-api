class AddApiKeyIndexToAccount < ActiveRecord::Migration[6.0]
  def change
  	add_index :accounts, :api_key, unique: true
  end
end
