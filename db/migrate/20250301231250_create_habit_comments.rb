class CreateHabitComments < ActiveRecord::Migration[7.1]
  def change
    create_table :habit_comments do |t|
      t.references :users, foreign_key: true
      t.references :habit_posts, foreign_key: true
      t.text :body

      t.timestamps
    end
  end
end
