class HabitPostsController < ApplicationController
  #確認ラスト
  before_action :authenticate_user!, only: [:new, :create, :edit, :show, :update, :destroy]
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

  #確認ラスト（set_habit_postを書いたことで短くなった）
  def edit
    #インスタンス変数は、form_withがあるedit.html.erbへ。
  end

  #確認ラスト（set_habit_postを書いたことで短くなった）
  def update
    if @habit_post.update(habit_post_params)
      redirect_to habit_post_path(@habit_post), notice: '編集が成功しました！'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  #確認ラスト（set_habit_postを書いたことで短くなった）
  def destroy
    @habit_post.destroy!
    redirect_to habit_posts_path, notice: '削除が成功しました！'
  end

  private

  def habit_post_params
    params.require(:habit_post).permit(:title, :body, :image)
  end

  #確認ラスト
  #投稿が消されるなど、なかった場合または現在ログインしているユーザーではない場合、一覧画面に遷移されメッセージが表示される
  #どのタイミングで@habit_postにデータが入るのか確認
  def set_habit_post
    @habit_post = current_user.habit_posts.find_by(id: params[:id])
    unless @habit_post
      flash[:alert] = "投稿が見つからない、もしくはアクセス権限がありません。"
      redirect_to habit_posts_path
    end
  end

end