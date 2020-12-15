class RemoveApiKeyFromAdminUser < ActiveRecord::Migration[6.0]
  def change
  	remove_column :admin_users, :api_key
  end
end
