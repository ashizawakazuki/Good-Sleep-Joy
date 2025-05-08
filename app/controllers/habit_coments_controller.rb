class HabitComentsController < ApplicationController

  def create
    @habit_post = habitPost.find(params[:habit_post_id])
    @habit_comment = @habit_post.habit_comments.build(comment_params)
    @habit_comment.user = current_user
  
    if @habit_comment.save
      redirect_to habit_post_path(@habit_post), notice: 'コメントしました！'
    else
      redirect_to habit_post_path(@habit_post), alert: 'コメントが失敗しました。'
    end
  end

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
