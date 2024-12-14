class AddImageToHabitPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :habit_posts, :image, :string
  end
end
