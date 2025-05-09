class ChangeCloumnsNotnullAddHabitComments < ActiveRecord::Migration[7.1]
  def change
    change_column :habit_comments, :user_id, :bigint, null: false
    change_column :habit_comments, :habit_post_id, :bigint, null: false
    change_column :habit_comments, :body, :text, null: false
  end
end
