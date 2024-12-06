class ItemPostsController < ApplicationController
  def index
    @item_posts = ItemPost.includes(:user)
  end
end
