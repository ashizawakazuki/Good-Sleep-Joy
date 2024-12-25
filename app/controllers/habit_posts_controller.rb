class HabitPostsController < ApplicationController
  #Deviseを導入したために使えるようになったメソッドで、ユーザーがログインしているかを判別し、未ログイン時には、自動的にログインページにリダイレクトさせる
  before_action :authenticate_user!, only: [:new, :create, :edit, :show, :update, :destroy]
  #set_habit_postで[:edit, :update, :destroy]アクションの前に、「投稿が削除されておらず存在するかどうか、また、アクセス権限があるか（人の投稿でないか）」を確認している
  before_action :set_habit_post, only: [:edit, :update, :destroy]

  #N+1問題が発生しないように、最初にHabitPost（投稿）とUser（ユーザー）のデータを、includesで@habit_postsに入れておく
  #「_habit_post.html.erb」の「habit_post.user.name」等で余計なクエリ（DBへの問い合わせ）を発行しないようにしている
  #ここでallを使ってしまうと、都度「_habit_post.html.erb」で余計なクエリが「index.html.erb」のループの回数分発行されてしまう
  def index
    @habit_posts = HabitPost.includes(:user)
  end

  def new
    @habit_post = HabitPost.new
  end

  def create
    @habit_post = current_user.habit_posts.build(habit_post_params)
    if @habit_post.save
      redirect_to habit_posts_path, notice: '投稿が成功しました！'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show
    @habit_post = HabitPost.find(params[:id])
  end

  #set_habit_postで投稿データを先に取得している
  #インスタンス変数は、form_withがあるedit.html.erbへ
  def edit; end

  #set_habit_postで投稿データを先に取得している
  def update
    if @habit_post.update(habit_post_params)
      redirect_to habit_post_path(@habit_post), notice: '編集が成功しました！'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  #set_habit_postで投稿データを先に取得している
  #最初はインスタンス変数でではなかったが、他のアクション（updateやedit）と揃えるためにインスタンス変数に統一した
  def destroy
    @habit_post.destroy!
    redirect_to habit_posts_path, notice: '削除が成功しました！'
  end

  private

  def habit_post_params
    params.require(:habit_post).permit(:title, :body, :image)
  end

  #投稿が消されるなどして存在しない場合、または現在ログインしているユーザーではない場合、メッセージが表示され一覧画面に遷移される
  #「find」はIDが存在しない場合に例外（エラー）を発生させてしまうため、IDが存在しない場合、nilを返す「find_by」使用してフラッシュメッセージを表示している
  def set_habit_post
    @habit_post = current_user.habit_posts.find_by(id: params[:id])
    unless @habit_post
      redirect_to habit_posts_path, alert: "投稿が見つからない、もしくはアクセス権限がありません。"
    end
  end
end