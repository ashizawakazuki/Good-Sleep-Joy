class AddSleepTimeToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :sleep_time, :time
  end
end
