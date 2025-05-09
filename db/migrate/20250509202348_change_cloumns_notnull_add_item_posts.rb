class ChangeCloumnsNotnullAddItemPosts < ActiveRecord::Migration[7.1]
  def change
    change_column :item_posts, :user_id, :bigint, null: false
    change_column :item_posts, :item_tag_id, :bigint, null: false
  end
end
