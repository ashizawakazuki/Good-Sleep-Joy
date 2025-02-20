class DropItemPostCommets < ActiveRecord::Migration[7.1]
  def change
    drop_table :item_post_commets
  end
end
