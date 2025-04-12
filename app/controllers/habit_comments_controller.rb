class HabitCommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  # _form.html.erbで指定したURL(habit_post_habit_comments_path)、でリクエストを行いcreateアクションが動き出す
  def create
    @habit_post = HabitPost.find(params[:habit_post_id])  # コメントされている該当するhabitPostを取得
    @habit_comment = @habit_post.habit_comments.build(comment_params)  # buildでparamsで持ってきた投稿のコメントを作成
    @habit_comment.user = current_user  # current_userには現在ログインしている人のIDが入っているため、コメントのuser_idにログインユーザーのIDをセット
    
    if @habit_comment.save
      redirect_to habit_post_path(@habit_post), notice: 'コメントしました！'
    else
      redirect_to habit_post_path(@habit_post), alert: 'コメントが失敗しました。'
    end
  end
  
  # 現在ログイン中のユーザーのアイテムに関するコメントの中から、指定されたidを探して削除
  # 削除できたらメッセージが表示される
  def destroy
    @habit_comment = current_user.habit_comments.find_by(id: params[:id])
    @habit_comment.destroy!
    redirect_to habit_post_path(@habit_comment.habit_post), notice: '削除が成功しました！'
  end
  
  
  private
    
  def comment_params
    params.require(:habit_comment).permit(:body)
  end
end
  