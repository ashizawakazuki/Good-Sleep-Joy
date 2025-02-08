class ItemLike < ApplicationRecord
  belongs_to :user
  belongs_to :item_post
end
