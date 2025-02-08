class ItemLike < ApplicationRecord
  belongs_to :user
  belongs_to :item_post

  validates :user_id, uniqueness: { scope: :item_post_id }
end
