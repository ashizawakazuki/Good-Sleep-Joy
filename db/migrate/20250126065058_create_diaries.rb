class CreateDiaries < ActiveRecord::Migration[7.1]
  def change
    create_table :diaries do |t|
      t.datetime :date
      t.string :title

      t.timestamps
    end
  end
end
