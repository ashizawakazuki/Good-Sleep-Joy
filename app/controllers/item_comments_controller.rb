class ItemCommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  # _form.html.erbで指定したURL(item_post_item_comments_path)、でリクエストを行いcreateアクションが動き出す
  def create
    @item_post = ItemPost.find(params[:item_post_id])  # コメントされている該当するItemPostを取得
    @item_comment = @item_post.item_comments.build(comment_params)  # buildでparamsで持ってきた投稿のコメントを作成
    @item_comment.user = current_user  # current_userには現在ログインしている人のIDが入っているため、コメントのuser_idにログインユーザーのIDをセット
  
    if @item_comment.save
      redirect_to item_post_path(@item_post), notice: 'コメントしました！'
    else
      redirect_to item_post_path(@item_post), alert: '投稿が失敗しました。'
    end
  end

  # 現在ログイン中のユーザーのアイテムに関するコメントの中から、指定されたidを探して削除
  # 削除できたらメッセージが表示される
  def destroy
    @item_comment = current_user.item_comments.find_by(id: params[:id])
    @item_comment.destroy!
    redirect_to item_post_path(@item_comment.item_post), notice: '削除が成功しました！'
  end


  private
  
  def comment_params
    params.require(:item_comment).permit(:body)
  end


end