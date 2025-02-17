class ItemLikesController < ApplicationController
  def create
    # いいねされた投稿を持ってきてitem_postに代入（どの投稿にいいねをするのかを特定するため）
    @item_post = ItemPost.find(params[:item_post_id])
    # 現在のログインユーザーが、このitem_postにいいねをする（Userモデルにあるitem_likeメソッドを使用）
    current_user.item_like(@item_post)
    #ridirect_toを使わなくても_item_like.html.erbのlink_toにturboの記述があるため、該当するxxxxx.turbo_stream.erbファイル（item_likes/create）を探す
  end
    
  def destroy
    # いいねを解除する投稿を持ってきてitem_postに代入（どの投稿のいいねを解除するのかを特定するため）
    @item_post = ItemPost.find(params[:item_post_id])
    # ログインユーザーがつけたitem_postのいいねを探す
    item_like = current_user.item_likes.find_by(item_post: @item_post)
    # もしいいねが存在すれば削除する（if文の後置）
    item_like.destroy if item_like
    #ridirect_toを使わなくても_item_unlike.html.erbのlink_toにturboの記述があるため、該当するxxxxx.turbo_stream.erbファイル（item_likes/destroy）を探す
  end
end