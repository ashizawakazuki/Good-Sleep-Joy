class RenameHabitPostsIdToHabitPostId < ActiveRecord::Migration[7.1]
  def change
    rename_column :habit_comments, "habit_posts_id", "habit_post_id"
  end
end
