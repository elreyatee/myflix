class RenameTokenColumn < ActiveRecord::Migration
  def change
    rename_column :users, :token, :password_reset_token
  end
end
