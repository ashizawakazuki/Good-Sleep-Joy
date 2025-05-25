class HabitLike < ApplicationRecord
  belongs_to :user
  belongs_to :habit_post, counter_cache: true # いいねが押されたら、habit_postのhabit_likes_countに+1(-1)カウントするよう設定

  # どのカラムを検索対象にして許可するかを設定
  def self.ransackable_attributes(auth_object = nil)
    []
  end
  
  # アソシエーションで関連づいているモデルでどのモデルを検索対象にしているかを設定
  def self.ransackable_associations(auth_object = nil)
    ["item_post"]
  end

  validates :user_id, uniqueness: { scope: :habit_post_id }
end
