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
      item_comment = build(:item_comment, body: nil )
      item_comment.valid?
      expect(item_comment.errors[:body]).not_to be_empty
    end
  end
end
