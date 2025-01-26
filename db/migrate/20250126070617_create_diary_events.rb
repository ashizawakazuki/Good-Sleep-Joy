class CreateDiaryEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :diary_events do |t|
      t.text :content

      t.timestamps
    end
  end
end
