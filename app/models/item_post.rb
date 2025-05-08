class ItemPost < ApplicationRecord
  #バリデーション設定(DBに保存される前にデータが正しい形式や条件を満たしているかを「presence」や「length」で確認)
  validates :title, presence: true, length: { maximum: 100 } #空でない、最大100文字
  validates :body, presence: true, length: { maximum: 1000 } #空でない、最大1000文字

  belongs_to :user
  belongs_to :item_tag
  has_many :item_likes, dependent: :destroy
  has_many :item_comments, dependent: :destroy

  # どのカラムを検索対象にして許可するかを設定
  def self.ransackable_attributes(auth_object = nil)
    ["title","body","item_tag_id"]
  end
  
  # アソシエーションで関連づいているモデルでどのモデルを検索対象にしているかを設定
  def self.ransackable_associations(auth_object = nil)
    []
  end

  # ItemPostImageUploaderは「画像管理の機能」(app/uplodersの中にファイルあり）
  # item_post_imageはカラム名で「画像を置く場所」
  # ここでのマウントとは「CarrierWaveのアップロード機能をモデルのカラムに関連付け、カラムに特別な機能を付与する操作]
  # CarrierWaveでアップロードされた画像のURLを取得することができるようになる
  mount_uploader :item_post_image, ItemPostImageUploader
end
 