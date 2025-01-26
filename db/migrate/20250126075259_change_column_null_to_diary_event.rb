class ChangeColumnNullToDiaryEvent < ActiveRecord::Migration[7.1]
  def change
    change_column_null :diary_events, :content, false
  end
end
