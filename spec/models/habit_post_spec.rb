require 'rails_helper'

RSpec.describe HabitPost, type: :model do
  describe 'バリデーションチェック' do
    it 'titleとbodyとhabit_post_imageが有効であること' do
      habit_post = build(:habit_post)
      expect(habit_post).to be_valid 
    end

    it 'titleが空だと無効であること' do
      habit_post = build(:habit_post, title: nil)
      habit_post.valid?
      expect(habit_post.errors[:title]).not_to be_empty
    end

    it 'titleが51文字以上だと無効であること' do
      habit_post = build(:habit_post, title: "テストタイトル" * 8)
      habit_post.valid?
      expect(habit_post.errors[:title]).not_to be_empty
    end

    it 'bodyが空だと無効であること' do
      habit_post = build(:habit_post, body: nil)
      habit_post.valid?
      expect(habit_post.errors[:body]).not_to be_empty
    end

    it 'bodyが1001文字以上だと無効であること' do
      habit_post = build(:habit_post, body: "テスト本文" * 201)
      habit_post.valid?
      expect(habit_post.errors[:body]).not_to be_empty
    end

    it 'habit_post_imageが空だと無効であること' do
      habit_post = build(:habit_post, habit_post_image: nil)
      habit_post.valid?
      expect(habit_post.errors[:habit_post_image]).not_to be_empty
    end
  end
end
