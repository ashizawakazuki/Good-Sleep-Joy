require 'rails_helper'

RSpec.describe ItemPost, type: :model do #ItemPostのモデルであることを意味
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
end