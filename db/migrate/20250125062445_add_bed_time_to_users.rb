class AddBedTimeToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :bed_time, :time
  end
end
