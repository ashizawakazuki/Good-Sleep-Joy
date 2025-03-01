class HabitPost < ApplicationRecord
  #バリデーション設定(DBに保存される前にデータが正しい形式や条件を満たしているかを「presence」や「length」で確認)
  validates :title, presence: true, length: { maximum: 100 } #空でない、最大100文字
  validates :body, presence: true, length: { maximum: 1000 } #空でない、最大1000文字

  belongs_to :user
  has_many :habit_likes, dependent: :destroy
  has_many :habit_comments, dependent: :destroy

end
