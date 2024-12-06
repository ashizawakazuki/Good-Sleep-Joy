class ItemPostsController < ApplicationController
  def index
    @item_posts = ItemPost.includes(:user)
  end
  #上記は全ての（複数の）データを格納するから複数形の@item_posts、下記は１つの投稿を格納するから単数系の@item_post
  def new
    @item_post = ItemPost.new # ユーザーが入力したデータを受け取れるよう空のインスタンスを用意し、ビューに渡す
  end

end
