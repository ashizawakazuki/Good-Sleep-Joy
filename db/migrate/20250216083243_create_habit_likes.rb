class CreateHabitLikes < ActiveRecord::Migration[7.1]
  def change
    create_table :habit_likes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :habit_post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
