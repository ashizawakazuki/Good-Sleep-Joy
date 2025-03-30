class HabitLike < ApplicationRecord
  belongs_to :user
  belongs_to :habit_post

  # どのカラムを検索対象にして許可するかを設定している
  def self.ransackable_attributes(auth_object = nil)
    []
  end
  
  # アソシエーションで関連づいているモデルでどのモデルを検索対象にしているかを設定している
  def self.ransackable_associations(auth_object = nil)
    ["item_post"]
  end

  validates :user_id, uniqueness: { scope: :habit_post_id }
end
