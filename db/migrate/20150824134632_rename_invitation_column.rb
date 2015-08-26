class RenameInvitationColumn < ActiveRecord::Migration
  def change
    rename_column :invitations, :inviter_id, :user_id
  end
end
