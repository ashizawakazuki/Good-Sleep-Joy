class RenameUsersIdToUserId < ActiveRecord::Migration[7.1]
  def change
    rename_column :item_comments, :users_id, :user_id
  end
end
