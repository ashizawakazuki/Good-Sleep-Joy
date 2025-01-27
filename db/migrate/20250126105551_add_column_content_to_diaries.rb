class AddColumnContentToDiaries < ActiveRecord::Migration[7.1]
  def change
    add_column :diaries, :content, :text
  end
end
