class User < ApplicationRecord
  validates :name, presence: true
  # deviseによるログイン等の機能をUserモデルに組み込んでいる
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2]

  has_many :item_posts, dependent: :destroy
  has_many :habit_posts, dependent: :destroy
  has_many :diaries, dependent: :destroy
  has_many :item_likes, dependent: :destroy

  # 下記では単なる関連付け（元々のアソシエーション設定）ではなく、liked_item_postsという新たなメソッドを作るために定義
  # through: :item_likes で中間テーブルを経由し、item_postのデータを持ってくる
  # この一行で「ユーザーがいいねした投稿」の一覧を簡単に取得できるメソッドを作成
  has_many :liked_item_posts, through: :item_likes, source: :item_post
  has_many :habit_likes, dependent: :destroy
  has_many :liked_habit_posts, through: :habit_likes, source: :habit_post
  has_many :item_comments, dependent: :destroy
  has_many :habit_comments, dependent: :destroy

  # 独自のメソッドを定義。Userモデルに書いているので、Userインスタンスに対して使えるメソッド
  # ビューファイルの「current_user_own?(item_post)」でitem_postがresourceに代入される
  def own?(resource)
    resource&.user_id == id #左辺「この投稿のID」と、右辺「現在ログインしてるID」は一致してるのかを確認
  end

  # 「liked_item_posts」は「ユーザーがいいねした投稿」の一覧を取得できるメソッド
  def item_like(item_post)
    liked_item_posts << item_post
  end

  def item_unlike(item_post)
    liked_item_posts.destroy(item_post)
  end

  def item_liked?(item_post)
    liked_item_posts.include?(item_post)
  end

  def habit_like(habit_post)
    liked_habit_posts << habit_post
  end

  def habit_unlike(habit_post)
    liked_habit_posts.destroy(habit_post)
  end

  def habit_liked?(habit_post)
    liked_habit_posts.include?(habit_post)
  end

  mount_uploader :avatar, AvatarUploader

  # Googleログインしたユーザーをアプリに登録する(authにユーザー情報が入る)
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|

      user.name = auth.info.name
      user.avatar = auth.info.image
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

end
