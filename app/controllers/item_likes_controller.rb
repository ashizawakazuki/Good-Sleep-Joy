class ItemLikesController < ApplicationController
  def create
    # いいねされた投稿を持ってきてitem_postに代入（どの投稿にいいねをするのかを特定するため）
    item_post = ItemPost.find(params[:item_post_id])
    # 現在のログインユーザーが、このitem_postにいいねをする（Userモデルにあるitem_likeメソッドを使用）
    current_user.item_like(item_post)
    redirect_to item_posts_path, notice: 'いいねをしました！'
  end
    
  def destroy
    # いいねを解除する投稿を持ってきてitem_postに代入（どの投稿のいいねを解除するのかを特定するため）
    item_post = ItemPost.find(params[:item_post_id])
    # ログインユーザーがつけたitem_postのいいねを探す
    item_like = current_user.item_likes.find_by(item_post: item_post)
    # もしいいねが存在すれば削除する（if文の後置）
    item_like.destroy if item_like
    redirect_to item_posts_path, notice: 'いいねを解除しました！'
  end
end