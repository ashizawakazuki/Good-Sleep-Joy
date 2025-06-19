require 'rails_helper'

RSpec.describe ItemComment, type: :model do
  describe 'バリデーションチェック' do
    it 'bodyが有効であること' do
      item_comment = build(:item_comment)
      expect(item_comment).to be_valid
    end

    it 'bodyが65,536以上だと無効であること' do
      item_comment = build(:item_comment, body: "a" * 65_536)
      item_comment.valid?
      expect(item_comment.errors[:body]).not_to be_empty
    end

    it 'bodyが空だと無効であること' do
      item_comment = build(:item_comment, body: nil)
      item_comment.valid?
      expect(item_comment.errors[:body]).not_to be_empty
    end

    describe 'アソシエーションチェック' do
      it 'Userに属していること' do
        user = create(:user)
        item_comment = create(:item_comment, user_id: user.id)
        expect(item_comment.user).to eq(user)
      end

      it 'ItemPostに属していること' do
        item_post = create(:item_post)
        item_comment = create(:item_comment, item_post_id: item_post.id)
        expect(item_comment.item_post).to eq(item_post)
      end
    end
  end
end
