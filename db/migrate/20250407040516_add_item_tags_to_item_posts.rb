class AddItemTagsToItemPosts < ActiveRecord::Migration[7.1]
  def change
    add_reference :item_posts, :item_tag, foreign_key: true
  end
end
