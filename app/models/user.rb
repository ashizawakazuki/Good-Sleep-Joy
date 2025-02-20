class User < ApplicationRecord
  validates :name, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :item_posts, dependent: :destroy #ユーザーが削除された時、関連するモデル（item_post）のレコード削除される
  has_many :habit_posts, dependent: :destroy
  has_many :diaries, dependent: :destroy
  has_many :item_likes, dependent: :destroy
  # 下記では単なる関連付け（元々のアソシエーション設定）ではなく、liked_item_postsという新たなメソッドを作るために定義している
  # through: :item_likes で中間テーブルを経由し、item_postのデータを持ってくる
  # つまりこの一行で「ユーザーがいいねした投稿」の一覧を簡単に取得できるメソッド を作っている。
  has_many :liked_item_posts, through: :item_likes, source: :item_post
  has_many :habit_likes, dependent: :destroy
  has_many :liked_habit_posts, through: :habit_likes, source: :habit_post
  has_many :item_comments, dependent: :destroy

 #これは独自のメソッドを定義。Userモデルに書いているので、Userインスタンス（userテーブルから取り出したデータが入っているインスタンス）に対して使えるメソッド
 #resourceは引数であり、ビューファイルの「current_user_own?(item_post)」でitem_postがresourceに代入される
 #結果、own?メソッドの中で「item_post.user.id == id」という文になる
 #idはRailsが用意しているもので、現在ログインしているユーザー（current_user）を指す（本当はself.idらしいが、現時点ではよくわかってない）
 #アプリのどこでも使えるが、実際にはコントローラとビューで使う（ルーティングとかでは使われない）
  def own?(resource)
    resource&.user_id == id #左辺「この投稿のID」と、右辺「現在ログインしてるID」は一致してるのかを見ている
  end

   #上記にも書いたように「liked_item_posts」は「ユーザーがいいねした投稿」の一覧を簡単に取得できるメソッド
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

end
