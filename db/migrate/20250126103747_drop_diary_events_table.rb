class DropDiaryEventsTable < ActiveRecord::Migration[7.1]
  def up
    drop_table :diary_events
  end
end
