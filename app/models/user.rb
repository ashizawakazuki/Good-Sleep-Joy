class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :item_posts, dependent: :destroy #ユーザーが削除された時、関連するモデル（item_post）のレコード削除される

  def own?(resource)
    resource.user_id == id
  end

end
