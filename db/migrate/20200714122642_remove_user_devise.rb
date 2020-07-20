class RemoveUserDevise < ActiveRecord::Migration[6.0]
  def change
    # Devise attributes
    remove_index :users, :email
    remove_index :users, :reset_password_token

    remove_column :users, :email
    remove_column :users, :encrypted_password

    remove_column :users, :reset_password_token
    remove_column :users, :reset_password_sent_at
    remove_column :users, :allow_password_change

    remove_column :users, :sign_in_count
    remove_column :users, :current_sign_in_at
    remove_column :users, :last_sign_in_at
    remove_column :users, :current_sign_in_ip
    remove_column :users, :last_sign_in_ip

    # DeviseTokenAuth attrbiutes
    remove_index :users, %i[uid provider]

    remove_column :users, :provider
    remove_column :users, :uid
    remove_column :users, :tokens

    # User attributes
    remove_column :users, :first_name
    remove_column :users, :last_name
    remove_column :users, :username
  end
end
