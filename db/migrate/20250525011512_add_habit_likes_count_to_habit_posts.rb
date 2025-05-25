class AddHabitLikesCountToHabitPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :habit_posts, :habit_likes_count, :integer, default: 0, null: false
  end
end
