class AddItemLikesCountToItemPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :item_posts, :item_likes_count, :integer, default: 0, null: false
  end
end
