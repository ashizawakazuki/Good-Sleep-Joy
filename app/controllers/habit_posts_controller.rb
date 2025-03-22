class HabitPostsController < ApplicationController
  #Deviseを導入したために使えるようになったメソッドで、ユーザーがログインしているかを判別し、未ログイン時には、自動的にログインページにリダイレクトさせる
  before_action :authenticate_user!, only: [:new, :create, :edit, :show, :update, :destroy]
  #set_habit_postで[:edit, :update, :destroy]アクションの前に、「投稿が削除されておらず存在するかどうか、また、アクセス権限があるか（人の投稿でないか）」を確認している
  before_action :set_habit_post, only: [:edit, :update, :destroy]

  #N+1問題が発生しないように、最初にHabitPost（投稿）とUser（ユーザー）のデータを、includesで@habit_postsに入れておく
  #「_habit_post.html.erb」の「habit_post.user.name」等で余計なクエリ（DBへの問い合わせ）を発行しないようにしている
  #ここでallを使ってしまうと、都度「_habit_post.html.erb」で余計なクエリが「index.html.erb」のループの回数分発行されてしまう
  #「page(params[:page])で、ページネーションで分けているページを受け取り、per(20)で1ページに表示する件数を指定している。
  def index
    @habit_posts = HabitPost.includes(:user).order(created_at: :desc).page(params[:page]).per(20)
  end

  def new
    @habit_post = HabitPost.new
  end

  def create
    @habit_post = current_user.habit_posts.build(habit_post_params)
    if @habit_post.save
      redirect_to habit_posts_path, notice: '投稿が成功しました！'
    else
      flash.now[:alert] = '投稿に失敗しました。入力内容を確認してください'
      render :edit, status: :unprocessable_entity
    end
  end

  def show
    @habit_post = HabitPost.find(params[:id])
    @habit_comment = HabitComment.new
    @habit_comments = @habit_post.habit_comments.includes(:user).order(created_at: :asc)
  end

  #set_habit_postで投稿データを先に取得している
  #今ログインしているユーザーの投稿（DBのテーブルの表を思い浮かべる。）のうち、paramsに格納されているIDの該当するものをfindで探して、インスタンス変数に代入している
  #インスタンス変数は、form_withがあるedit.html.erbへ
  def edit; end

  #set_habit_postで投稿データを先に取得している
  #①「@habit_post = current_user.habit_posts.find(params[:id])」で、更新対象のデータをまず持ってくる
  #②createアクション同様、フォームで更新した内容がparamsで送られてくる（ストロングパラメータであるitem_post_paramsで絞り込み）
  #③updateメソッドで、フォームからきた新しいデータに、用意した更新対象の@item_postを更新する
  #④成功時は詳細画面へ、失敗時はもう一度編集画面を描写する
  def update
    if @habit_post.update(habit_post_params)
      redirect_to habit_post_path(@habit_post), notice: '編集が成功しました！'
    else
      flash.now[:alert] = '投稿に失敗しました。入力内容を確認してください'
      render :edit, status: :unprocessable_entity
    end
  end

  #set_habit_postで投稿データを先に取得している
  #最初はインスタンス変数でではなかったが、他のアクション（updateやedit）と揃えるためにインスタンス変数に統一した
  #destroy!では失敗時に例外（エラー）を発生させ、その場で処理が止まるので、if文で成功・失敗を分ける必要がなくなる
  def destroy
    @habit_post.destroy!
    redirect_to habit_posts_path, notice: '削除が成功しました！'
  end

  def habit_likes
    @habit_like_posts = current_user.liked_habit_posts.includes(:user).order(created_at: :desc).page(params[:page]).per(20)
  end
  
  private

  def habit_post_params
    params.require(:habit_post).permit(:title, :body, :habit_post_image)
  end

  #投稿が消されるなどして存在しない場合、または現在ログインしているユーザーではない場合、メッセージが表示され一覧画面に遷移される
  #「find」はIDが存在しない場合に例外（エラー）を発生させてしまうため、IDが存在しない場合、nilを返す「find_by」を使用してフラッシュメッセージを表示している
  # if文の横の条件が「nil」or「false」と評価される場合、今回のunless文はその続きの処理を実行する（if文の場合は「true」で処理を実行する）
  def set_habit_post
    @habit_post = current_user.habit_posts.find_by(id: params[:id])
    unless @habit_post
      redirect_to habit_posts_path, alert: "投稿が見つからない、もしくはアクセス権限がありません。"
    end
  end
end