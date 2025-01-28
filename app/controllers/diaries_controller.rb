class DiariesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
    #後ほど復活させる
#   before_action :set_diary_post, only: [:update, :destroy]
  def index

  end

  def new
    @diary = Diary.new
  end

  def create
    @diary = current_user.diaries.build(diary_params)
    if @diary.save
      redirect_to profile_path, notice: '作成しました！今日も一日お疲れ様でした！'
    else
      flash.now[:alert] = '作成に失敗しました。入力内容を確認してください'
      render :new, status: :unprocessable_entity
  end
end

private

  def diary_params
    params.require(:diary).permit(:date, :title, :content)
  end

  #後ほど復活させる
#   def set_diary_post
#     @diary = current_user.diaries.find_by(id: params[:id])
#     unless @diary
#       redirect_to profile_path, alert: "投稿が見つからない、もしくはアクセス権限がありません。"
#     end
#   end
end
