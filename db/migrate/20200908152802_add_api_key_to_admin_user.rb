class AddApiKeyToAdminUser < ActiveRecord::Migration[6.0]
  def change
    add_column :admin_users, :api_key, :string
  end
end
