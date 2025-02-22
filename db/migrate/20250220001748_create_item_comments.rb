class CreateItemComments < ActiveRecord::Migration[7.1]
  def change
    create_table :item_comments do |t|
      t.references :users, foreign_key: true
      t.references :item_posts, foreign_key: true
      t.text :body

      t.timestamps
    end
  end
end
