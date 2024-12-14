class HabitPostsController < ApplicationController
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

  def edit
    @habit_post = current_user.habit_posts.find(params[:id])
  end

  def update
    @habit_post = current_user.habit_posts.find(params[:id])
    if @habit_post.update(habit_post_params)
      redirect_to habit_post_path,notice: '編集が成功しました！'
    else
      render :edit, status: :unprocessable_entity
    end
  end
  private

  def habit_post_params
    params.require(:habit_post).permit(:title, :body, :image)
  end
end
