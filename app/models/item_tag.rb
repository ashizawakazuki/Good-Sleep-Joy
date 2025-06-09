class ItemTag < ApplicationRecord
  validates :name, presence: true

  has_many :item_posts, dependent: :destroy
end
