require 'rails_helper'

RSpec.describe ItemPost, type: :model do # ItemPostのモデルであることを意味
  describe 'バリデーションチェック' do
    it 'titleとbodyが有効であること' do
      item_post = build(:item_post) # factory botによりitem_post.rbよりデータを生成
      expect(item_post).to be_valid # be_validでitem_postがバリデーションが通るかを検証
    end

    it 'titleが空だと無効であること' do
      item_post = build(:item_post, title: nil) # factory botにより生成されたtitleをnilに上書き
      item_post.valid? # バリデーションを通るか確認
      expect(item_post.errors[:title]).not_to be_empty # エラーメッセージが空でないかを判定
    end

    it 'titleが51文字以上だと無効であること' do
      item_post = build(:item_post, title: "テストタイトル" * 8)
      item_post.valid?
      expect(item_post.errors[:title]).not_to be_empty
    end

    it 'bodyが空だと無効であること' do
      item_post = build(:item_post, body: nil)
      item_post.valid?
      expect(item_post.errors[:body]).not_to be_empty
    end

    it 'bodyが1001文字以上だと無効であること' do
      item_post = build(:item_post, body: "テスト本文" * 201)
      item_post.valid?
      expect(item_post.errors[:body]).not_to be_empty
    end
  end

  describe 'アソシエーションチェック' do
    it 'Userに属していること' do
      user = create(:user) # factory botよりオブジェクトを生成し保存し、userに格納
      item_post = create(:item_post, user_id: user.id) # factory botにより生成されたオブジェクトのuser_idカラムにuser_idをセット
      expect(item_post.user).to eq(user) # item_post.userで生成されるオブジェクトとuserオブジェクトが一致しているか検証
    end

    it 'ItemTagに属していること' do
      item_tag = create(:item_tag)
      item_post = create(:item_post, item_tag_id: item_tag.id)
      expect(item_post.item_tag).to eq(item_tag)
    end

    it 'Item_likesを含んでいること' do
      item_post = create(:item_post)
      item_like1 = create(:item_like, item_post_id: item_post.id)
      item_like2 = create(:item_like, item_post_id: item_post.id)
      expect(item_post.item_likes).to include(item_like1, item_like2)
    end

    it 'Item_commentを含んでいること' do
      item_post = create(:item_post)
      item_comment1 = create(:item_comment, item_post_id: item_post.id)
      item_comment2 = create(:item_comment, item_post_id: item_post.id)
      expect(item_post.item_comments).to include(item_comment1, item_comment2)
    end
  end
end
