class ItemComment < ApplicationRecord
  validates :body, presence: true, length: { maximum: 65_535 }
  
  belongs_to :item_post, counter_cache: true # いいねが押されたら、item_commentのitem_comments_countに+1(-1)カウントするよう設定
  belongs_to :user
end
