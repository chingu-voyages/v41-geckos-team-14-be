class ChangeEmailColumnToUsernameOnUser < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :email, :username
  end
end
