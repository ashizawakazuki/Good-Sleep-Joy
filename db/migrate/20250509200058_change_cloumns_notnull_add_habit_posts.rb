class ChangeCloumnsNotnullAddHabitPosts < ActiveRecord::Migration[7.1]
  def change
    change_column :habit_posts, :user_id, :bigint, null: false
    change_column :habit_posts, :habit_tag_id, :bigint, null: false
    change_column :habit_posts, :habit_post_image, :string, null: false
  end
end
