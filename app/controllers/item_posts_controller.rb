class ItemPostsController < ApplicationController
  #確認ラスト
  before_action :authenticate_user!, only: [:new, :create, :edit, :show, :update, :destroy]
  before_action :set_item_post, only: [:edit, :update, :destroy]
  
  #N+1問題が発生しないように、最初にItemPost（投稿）とUser（ユーザー）のデータを、includesで@item_postsに入れておく
  #「_item_post.html.erb」の「item_post.user.name」等で余計なクエリ（DBへの問い合わせ）を発行しないようにしている
  #ここでallを使ってしまうと、都度「_item_post.html.erb」で余計なクエリが「index.html.erb」のループの回数分発行されてしまう
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
  #・「current_user」：今ログインしているユーザーのIDを取得
  #・「item_posts」：ユーザーと関連づけられた投稿を準備（投稿一覧を取得）（アソシエーションによるもの
    #→current_userのitem_postsテーブルを参照（持ってくる）イメージ
  #・buildメソッドでparamsで持ってきたデータを入れて新しいインスタンスを作成
    #→イメージは、「データベースに保存される前のレコードの枠組み」を作るって感じ(ノーション参照)
  #・「（board_post_params）」でフォームで送られてきたデータを絞り込み、代入される（board_post_paramsはストロングパラメータ）
  #④それを@item_postに入れる
  def create #createアクションには新しい投稿をDBに保存する処理を記述する
    @item_post = current_user.item_posts.build(item_post_params)
    if @item_post.save
      redirect_to item_posts_path, notice: '投稿が成功しました。'
    else
      render :new, status: :unprocessable_entity #あとでフラッシュメッセージ実装する
    end
  end

  #例えばhttp〜item_posts/30のようなリクエストが来たら、以下のようにparamsに格納されてRailsの世界にくる
  #params = { "id" => "30" }
  #Railsの世界に来たparamsを、以下のshowコントローラでparams[:id]と書いて、データベースからレコードを持ってくる
  #params[:id] = 30　と考えてよい
  #@item_postにIDが30の投稿が格納されてshowファイルへ
  def show 
    @item_post = ItemPost.find(params[:id])
  end
  
  #確認ラスト（set_habit_postを書いたことで短くなった）(なんでfindからfind_byになったのか確認)
  #今ログインしているユーザーの投稿（DBのテーブルの表を思い浮かべる。）のうち、paramsに格納されているIDの該当するものをfindで探して、インスタンス変数に代入している
  #インスタンス変数は、form_withがあるedit.html.erbへ。
  def edit 
  
  end

  #確認ラスト（set_habit_postを書いたことで短くなった）
  #①「@item_post = current_user.item_posts.find(params[:id])」で、更新対象のデータをまず持ってくる
  #②createアクション同様、フォームで更新した内容がparamsで送られてくる（ストロングパラメータであるitem_post_paramsで絞り込み）
  #③updateメソッドで、フォームからきた新しいデータに、用意した更新対象の@item_postを更新する
  #④成功時は詳細画面へ、失敗時はもう一度編集画面を描写する
  def update
    if @item_post.update(item_post_params)
      redirect_to item_post_path(@item_post), notice: '編集が成功しました！'
    else
      render :edit, status: :unprocessable_entity #あとでフラッシュメッセージ実装する
    end
  end

  #確認ラスト（set_habit_postを書いたことで短くなった）
  #destroy!では失敗時に例外を発生させ、その場で処理が止まるので、if文で成功・失敗を分ける必要がなくなる
  def destroy
    @item_post.destroy!
    redirect_to item_posts_path, notice: '削除が成功しました！'
  end
  
  private

  #ストロングパラメータは「データの保存や更新を許可するパラメータを指定して、セキュリティを強化する仕組み」
  #requireは、受け取る値のキーを書く（<%= form_with model: @item_post do |f| %>の場合、「item_post」になる）
  #permitには許可するカラム名を書く
  def item_post_params
    params.require(:item_post).permit(:title, :body, :item_post_image, :item_post_image_cache)
  end
  #送られてくるデータは、例えば以下の通り（正確にはrequireには、このキー（item_post）をかく
  #{
  # "item_post" => {
  #   "title" => "アイテム名",
  #   "body" => "本文内容"
  #  }
  # }

  #確認ラスト
  #投稿が消されるなど、なかった場合または現在ログインしているユーザーではない場合、一覧画面に遷移されメッセージが表示される
  #どのタイミングで@habit_postにデータが入るのか確認
  def set_item_post
    @item_post = current_user.item_posts.find_by(id: params[:id])
    unless @item_post
      flash[:alert] = "投稿が見つからない、もしくはアクセス権限がありません。"
      redirect_to item_posts_path
    end
  end
    
end
