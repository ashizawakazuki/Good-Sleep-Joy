class RenameItemPostsIdToItemPostId < ActiveRecord::Migration[7.1]
  def change
    rename_column :item_comments, :item_posts_id, :item_post_id
  end
end
