class CreateItemLikes < ActiveRecord::Migration[7.1]
  def change
    create_table :item_likes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :item_post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
