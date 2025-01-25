class ProfilesController < ApplicationController
  #Deviseを導入したために使えるようになったメソッドで、ユーザーがログインしているかを判別し、未ログイン時には、自動的にログインページにリダイレクトさせる
  before_action :authenticate_user!, only: [:show, :edit, :update]
  #set_habit_postでアクションの前に、「投稿が削除されておらず存在するかどうか、また、アクセス権限があるか（人の投稿でないか）」を確認している
  before_action :set_user, only: [:show, :edit, :update]  
  
  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to profile_path(@user), notice: '編集が成功しました!'
    else
      flash.now[:alert] = '投稿に失敗しました。入力内容を確認してください'
      render :edit, status: :unprocessable_entity
    end
  end

  
  private

  def set_user
    @user = User.find(current_user.id)
    unless @user
      redirect_to profile_path, alert: "投稿が見つからない、もしくはアクセス権限がありません。"
    end
  end

  def user_params
    params.require(:user).permit(:avatar, :avatar_cache, :name, :email, :wake_up_time, :bed_time, :sleep_time)
  end
end
  