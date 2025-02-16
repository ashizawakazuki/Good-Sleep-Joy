class HabitLikesController < ApplicationController
  def create
    habit_post = HabitPost.find(params[:habit_post_id])
    current_user.habit_like(habit_post)
    redirect_to habit_posts_path, notice: 'いいねをしました!'
  end

  def destroy
    habit_post = HabitPost.find(params[:habit_post_id])
    habit_like = current_user.habit_likes.find_by(habit_post: habit_post)
    habit_like.destroy if habit_like
    redirect_to habit_posts_path, notice: 'いいねを解除しました！'
  end
end
