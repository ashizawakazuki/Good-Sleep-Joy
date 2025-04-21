class HabitPost < ApplicationRecord
  #バリデーション設定(DBに保存される前にデータが正しい形式や条件を満たしているかを「presence」や「length」で確認)
  validates :title, presence: true, length: { maximum: 100 } #空でない、最大100文字
  validates :body, presence: true, length: { maximum: 1000 } #空でない、最大1000文字
  validates :habit_post_image, presence: true, if: -> { Rails.env.production? } # 本番環境のみ画像は必須に設定（開発環境ではダミーデータは画像を必須にする必要ないため）

  belongs_to :user
  belongs_to :habit_tag
  has_many :habit_likes, dependent: :destroy
  has_many :habit_comments, dependent: :destroy

  def self.ransackable_attributes(auth_object = nil)
    ["title","body","habit_tag_id"]
  end
  
  # アソシエーションで関連づいているモデルでどのモデルを検索対象にしているかを設定している（今回はなし
  def self.ransackable_associations(auth_object = nil)
    []
  end

end
