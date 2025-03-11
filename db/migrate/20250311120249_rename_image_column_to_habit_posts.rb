class RenameImageColumnToHabitPosts < ActiveRecord::Migration[7.1]
  def change
    rename_column :habit_posts, :image, :habit_post_image
  end
end
