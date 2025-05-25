class ItemPostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :my_item_posts]
  before_action :set_item_post, only: [:edit, :update, :destroy]
  
  def index
    @q = ItemPost.ransack(params[:q])
    @item_posts = @q.result(distinct: true).includes(:user, :item_comments, :item_likes, :item_tag).order(created_at: :desc).page(params[:page]).per(12)
  end

  def new
    @item_post = ItemPost.new # ユーザーが入力したデータを受け取れるよう空のインスタンスを用意し、ビューに渡す
  end

  def create
    @item_post = current_user.item_posts.build(item_post_params)
    if @item_post.save
      redirect_to item_posts_path, notice: '投稿が成功しました！'
    else
      flash.now[:alert] = '投稿に失敗しました。入力内容を確認してください'
      render :new, status: :unprocessable_entity
    end
  end

  def show 
    @item_post = ItemPost.find(params[:id])
    @item_comment = ItemComment.new
    @item_comments = @item_post.item_comments.includes(:user).order(created_at: :asc)
  end
  
  def edit; end

  def update
    if @item_post.update(item_post_params)
      redirect_to item_post_path(@item_post), notice: '編集が成功しました！'
    else
      flash.now[:alert] = '投稿に失敗しました。入力内容を確認してください'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item_post.destroy!
    redirect_to item_posts_path, notice: '削除が成功しました！'
  end
  
  def item_likes
    @q = current_user.liked_item_posts.ransack(params[:q])
    @item_like_posts = @q.result(distinct: true).includes(:user, :item_comments, :item_tag).order(created_at: :desc).page(params[:page]).per(20)
    @active_tab = "item_likes"
    render "profiles/show"
  end

  def ranking
    @item_post_ranking = ItemPost.includes(:user).find(ItemLike.group(:item_post_id).order('count(id) desc').limit(5).pluck(:item_post_id))
  end

  def search
    @item_posts = ItemPost.where("title like ?", "%#{params[:q]}%").limit(5)
    render partial: "search"
  end

  def my_item_posts
    @my_item_posts = current_user.item_posts.includes(:user, :item_comments, :item_likes, :item_tag).order(created_at: :desc)
    @active_tab = "my_item_posts"
    render "profiles/show"
  end

  private

  def item_post_params
    params.require(:item_post).permit(:title, :body, :item_post_image, :item_post_image_cache, :item_tag_id)
  end

  def set_item_post
    @item_post = current_user.item_posts.find_by(id: params[:id])
    unless @item_post
      redirect_to item_posts_path, alert: "投稿が見つからない、もしくはアクセス権限がありません。"
    end
  end
end
