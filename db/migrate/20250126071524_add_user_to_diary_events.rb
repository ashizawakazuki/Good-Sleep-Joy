class AddUserToDiaryEvents < ActiveRecord::Migration[7.1]
  def change
    add_reference :diary_events, :user, null: false, foreign_key: true
  end
end
