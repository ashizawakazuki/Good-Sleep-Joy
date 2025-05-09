class ChangeCloumnsNotnullAddDiaries < ActiveRecord::Migration[7.1]
  def change
    change_column :diaries, :date, :datetime, null: false
    change_column :diaries, :content, :text, null: true
  end
end
