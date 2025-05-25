class HabitComment < ApplicationRecord
  validates :body, presence: true, length: { maximum: 65_535}

  belongs_to :habit_post, counter_cache: true # いいねが押されたら、habit_postのhabit_comments_countに+1(-1)カウントするよう設定
  belongs_to :user
end
