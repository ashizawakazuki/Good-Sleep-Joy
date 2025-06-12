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

  describe 'アソシエーションチェック' do
    it 'Userに属していること' do
      user = create(:user)
      habit_post = create(:habit_post, user_id: user.id)
      expect(habit_post.user).to eq(user)
    end

    it 'HabitTagに属していること' do
      habit_tag = create(:habit_tag)
      habit_post = create(:habit_post, habit_tag_id: habit_tag.id)
      expect(habit_post.habit_tag).to eq(habit_tag)
    end

    it 'HabitLikesを含んでいること' do
      habit_post = create(:habit_post)
      habit_like1 = create(:habit_like, habit_post_id: habit_post.id)
      habit_like2 = create(:habit_like, habit_post_id: habit_post.id)
      expect(habit_post.habit_likes).to include(habit_like1,habit_like2)
    end

    it 'HabitCommentsを含んでいること' do
      habit_post = create(:habit_post)
      habit_comment1 = create(:habit_comment, habit_post_id: habit_post.id)
      habit_comment2 = create(:habit_comment, habit_post_id: habit_post.id)
      expect(habit_post.habit_comments).to include(habit_comment1,habit_comment2)
    end
  end
end
