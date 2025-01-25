class AddWakeUpTimeToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :wake_up_time, :time
  end
end
