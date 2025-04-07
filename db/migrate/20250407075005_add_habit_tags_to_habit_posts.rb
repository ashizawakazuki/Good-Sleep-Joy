class AddHabitTagsToHabitPosts < ActiveRecord::Migration[7.1]
  def change
    add_reference :habit_posts, :habit_tag, foreign_key: true
  end
end
