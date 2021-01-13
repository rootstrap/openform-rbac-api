class RemoveInvitationsFromUsers < ActiveRecord::Migration[6.0]
    def change
        remove_column :users, :invitation_token, if_exists: true
        remove_column :users, :invitation_created_at, if_exists: true
        remove_column :users, :invitation_sent_at, if_exists: true
        remove_column :users, :invitation_accepted_at, if_exists: true
        remove_column :users, :invitation_limit, if_exists: true
        remove_column :users, :invited_by_type, if_exists: true
        remove_column :users, :invited_by_id, if_exists: true
        remove_column :users, :invitations_count, if_exists: true
    end
end
