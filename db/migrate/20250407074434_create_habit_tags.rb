class CreateHabitTags < ActiveRecord::Migration[7.1]
  def change
    create_table :habit_tags do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
