class RenameUsers < ActiveRecord::Migration[5.1]
  def change
    drop_table :users
    rename_table :admin_users, :users
  end
end
