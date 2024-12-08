class ItemPostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  
  def index
    @item_posts = ItemPost.includes(:user)
  end
  #上記は全ての（複数の）データを格納するから複数形の@item_posts、下記は１つの投稿を格納するから単数系の@item_post

  #投稿機能の流れ(1〜５)
  #①newアクションで「@board=Board.new」で、ビューにてフォームの見た目を表示
  #②ユーザーがデータをフォームから送信すると、paramsとしてHTTPメソッド「Post」でリクエストが送られてくる
  def new
    @item_post = ItemPost.new # ユーザーが入力したデータを受け取れるよう空のインスタンスを用意し、ビューに渡す
  end
  #③送られてきたものに対応するコントローラのcreateアクションの中で、
  #・「current_user」は今ログインしてる人のIDを設定
  #・「boards」でログインしてるユーザーの投稿を紐付ける準備（投稿一覧を取得）
  #・「build」でインスタンス（新しいレコードを作成する準備）を生成（空ではない）
  #・「（board_params）」でフォームで送られてきたデータを絞り込み、代入される
  #④それを@boardに入れる
  def create #createアクションには新しい投稿をDBに保存する処理を記述する
    @item_post = current_user.item_posts.build(item_post_params)
    if @item_post.save
      redirect_to item_posts_path, notice: '投稿が成功しました。'
    else
      render :new, status: :unprocessable_entity #あとでフラッシュメッセージ実装する
    end
  end

  def show #あとで確認
    @item_post = ItemPost.find(params[:id])
  end
  
  def edit #あとで確認
    @item_post = current_user.item_posts.find(params[:id])
  end
     

  private

  #ストロングパラメータは「データの保存や更新を許可するパラメータを指定して、セキュリティを強化する仕組み」
  #requireは、<%= form_with model: @item_post do |f| %>のitem_postの部分を書く
  #permitには許可するカラム名を書く
  def item_post_params
    params.require(:item_post).permit(:title, :body)
  end
  #送られてくるデータは以下の通り（正確にはrequireには、このキー（item_post）をかく
  #{
  # "item_post" => {
  #   "title" => "アイテム名",
  #   "body" => "本文内容"
  #  }
  # }
end
