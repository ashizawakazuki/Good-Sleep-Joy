class AddItemPostImageToItemPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :item_posts, :item_post_image, :string
  end
end
