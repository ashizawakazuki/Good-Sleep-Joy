class RenameHabitUsersIdToUser < ActiveRecord::Migration[7.1]
  def change
    rename_column :habit_comments, "users_id", "user_id"
  end
end
