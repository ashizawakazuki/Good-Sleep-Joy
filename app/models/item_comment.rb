class ItemComment < ApplicationRecord
  validates :body, presence: true, length: { maximum: 65_535 }
  
  belongs_to :item_post
  belongs_to :user
end
