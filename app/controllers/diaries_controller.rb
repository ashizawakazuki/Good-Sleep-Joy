class DiariesController < ApplicationController
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

end
