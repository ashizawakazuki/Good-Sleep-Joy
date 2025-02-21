class ItemCommentsController < ApplicationController
    def create
      @item_post = ItemPost.find(params[:item_post_id])  # 関連するItemPostを取得
      @item_comment = @item_post.item_comments.build(comment_params)  # コメントを作成
      @item_comment.user = current_user  # ログインユーザーを設定
  
      if @item_comment.save
        redirect_to item_post_path(@item_post), notice: '投稿が成功しました。'
      else
        redirect_to item_post_path(@item_post), alert: '投稿が失敗しました。'
      end
    end
  
    private
  
    def comment_params
      params.require(:item_comment).permit(:body)
    end
  end