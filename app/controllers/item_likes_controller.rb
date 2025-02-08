class ItemLikesController < ApplicationController
  def create
    item_post = ItemPost.find(params[:item_post_id])
    current_user.item_like(item_post)
    redirect_to item_posts_path, notice: 'いいねをしました！'
  end
    
  def destroy
    item_post = ItemPost.find(params[:item_post_id])
    item_like = current_user.item_likes.find_by(item_post: item_post)
    item_like.destroy if item_like
    redirect_to item_posts_path, notice: 'いいねを解除しました！'
  end
end