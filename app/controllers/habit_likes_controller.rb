class HabitLikesController < ApplicationController
  def create
    @habit_post = HabitPost.find(params[:habit_post_id])
    current_user.habit_like(@habit_post)
    # ridirect_toを使わなくても_habit_like.html.erbのlink_toにturboの記述があるため、該当するxxxxx.turbo_stream.erbファイル（habit_likes/create）を探す
  end

  def destroy
    @habit_post = HabitPost.find(params[:habit_post_id])
    habit_like = current_user.habit_likes.find_by(habit_post: @habit_post)
    habit_like.destroy if habit_like
    # ridirect_toを使わなくても_habit_unlike.html.erbのlink_toにturboの記述があるため、該当するxxxxx.turbo_stream.erbファイル（habit_unlikes/create）を探す
  end
end
