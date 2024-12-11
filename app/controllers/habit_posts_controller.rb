class HabitPostsController < ApplicationController
  def index
    @habit_posts = HabitPost.includes(:user)
  end
end
