require 'rails_helper'

RSpec.describe Diary, type: :model do
  describe 'バリデーションチェック' do
    it 'dateとtitleとbodyが有効であること' do
      diary = build(:diary) 
      expect(diary).to be_valid
    end

    it 'dateが空だと無効であること' do
      diary = build(:diary, date: nil)
      diary.valid?
      expect(diary.errors[:date]).not_to be_empty
    end

    it 'titleが51文字以上だと無効であること' do
      diary = build(:diary, title: "テストタイトル" * 8)
      diary.valid?
      expect(diary.errors[:title]).not_to be_empty
    end

    it 'titleが空だと無効であること' do
      diary = build(:diary, title: nil)
      diary.valid?
      expect(diary.errors[:title]).not_to be_empty
    end

    it 'contentが1001文字以上だと無効であること' do
      diary = build(:diary, content: "テスト本文" * 201)
      diary.valid?
      expect(diary.errors[:content]).not_to be_empty
    end
  end

  describe 'アソシエーションチェック' do
    it 'Userに属していること' do
      user = create(:user)
      diary = create(:diary, user_id: user.id)
      expect(diary.user).to eq(user)
    end
  end
end
