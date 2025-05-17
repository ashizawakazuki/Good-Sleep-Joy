class HabitPostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_habit_post, only: [:edit, :update, :destroy]

  def index
    @q = HabitPost.ransack(params[:q])
    @habit_posts = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page]).per(20)
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
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @habit_post = HabitPost.find(params[:id])
    @habit_comment = HabitComment.new
    @habit_comments = @habit_post.habit_comments.includes(:user).order(created_at: :asc)
  end

  def edit; end

  def update
    if @habit_post.update(habit_post_params)
      redirect_to habit_post_path(@habit_post), notice: '編集が成功しました！'
    else
      flash.now[:alert] = '投稿に失敗しました。入力内容を確認してください'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @habit_post.destroy!
    redirect_to habit_posts_path, notice: '削除が成功しました！'
  end

  def habit_likes
    @q = current_user.liked_habit_posts.ransack(params[:q])
    @habit_like_posts = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page]).per(20)
    @active_tab = "habit_likes"
    render "profiles/show"
  end
  
  def ranking
    @habit_post_ranking = HabitPost.find(HabitLike.group(:habit_post_id).order('count(id) desc').limit(5).pluck(:habit_post_id))
  end

  def search
    @habit_posts = HabitPost.where("title like ?", "%#{params[:q]}%").limit(5)
    render partial: "search"
  end

  def my_habit_posts
    @my_habit_posts = current_user.habit_posts
    @active_tab = "my_habit_posts"
    render "profiles/show"
  end

  private

  def habit_post_params
    params.require(:habit_post).permit(:title, :body, :habit_post_image, :habit_tag_id)
  end

  def set_habit_post
    @habit_post = current_user.habit_posts.find_by(id: params[:id])
    unless @habit_post
      redirect_to habit_posts_path, alert: "投稿が見つからない、もしくはアクセス権限がありません。"
    end
  end
end