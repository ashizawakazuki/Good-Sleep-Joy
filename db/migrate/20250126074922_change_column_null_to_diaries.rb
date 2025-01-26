class ChangeColumnNullToDiaries < ActiveRecord::Migration[7.1]
  def change
    change_column_null :diaries, :title, false
  end
end
