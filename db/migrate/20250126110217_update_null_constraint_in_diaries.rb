class UpdateNullConstraintInDiaries < ActiveRecord::Migration[7.1]
  def change
    change_column_null :diaries, :content, false
  end
end
