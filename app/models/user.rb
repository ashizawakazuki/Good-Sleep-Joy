class User < ApplicationRecord
  validates :name, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :item_posts, dependent: :destroy #ユーザーが削除された時、関連するモデル（item_post）のレコード削除される
  has_many :habit_posts, dependent: :destroy
  has_many :diaries, dependent: :destroy
  has_many :item_like, dependent: :destroy

 #これは独自のメソッドを定義。Userモデルに書いているので、Userインスタンス（userテーブルから取り出したデータが入っているインスタンス）に対して使えるメソッド
 #resourceは引数であり、ビューファイルの「current_user_own?(item_post)」でitem_postがresourceに代入される
 #結果、own?メソッドの中で「item_post.user.id == id」という文になる
 #idはRailsが用意しているもので、現在ログインしているユーザー（current_user）を指す（本当はself.idらしいが、現時点ではよくわかってない）

  def own?(resource)
    resource.user_id == id #左辺「この投稿のID」と、右辺「現在ログインしてるID」は一致してるのかを見ている
  end

  mount_uploader :avatar, AvatarUploader

end
