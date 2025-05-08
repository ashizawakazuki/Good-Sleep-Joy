class ItemLikesController < ApplicationController
  def create
    @item_post = ItemPost.find(params[:item_post_id])
    current_user.item_like(@item_post)
  end
    
  def destroy
    @item_post = ItemPost.find(params[:item_post_id])
    item_like = current_user.item_likes.find_by(item_post: @item_post)
    item_like.destroy if item_like
  end
end