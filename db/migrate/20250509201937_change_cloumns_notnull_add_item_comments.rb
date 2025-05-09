class ChangeCloumnsNotnullAddItemComments < ActiveRecord::Migration[7.1]
  def change
    change_column :item_comments, :user_id, :bigint, null: false
    change_column :item_comments, :item_post_id, :bigint, null: false
    change_column :item_comments, :body, :text, null: false

  end
end
