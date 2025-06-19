require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションチェック' do
    it 'nameとemailとpasswordとpassword_confirmationが有効であること' do
      user = build(:user)
      expect(user).to be_valid
    end

    it 'nameが空だと無効であること' do
      user = build(:user, name: nil)
      user.valid?
      expect(user.errors[:name]).not_to be_empty
    end

    it 'emailが空だと無効であること' do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).not_to be_empty
    end

    it 'passwordが空だと無効であること' do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).not_to be_empty
    end

    it 'passwordが5文字以下だと無効であること' do
      user = build(:user, password: "a" * 5)
      user.valid?
      expect(user.errors[:password]).not_to be_empty
    end

    it 'passwordが129文字以上だと無効であること' do
      user = build(:user, password: "a" * 129)
      user.valid?
      expect(user.errors[:password]).not_to be_empty
    end
  end

  describe 'アソシエーションチェック' do
    it 'ItemPostsを含んでいること' do
      user = create(:user)
      item_post1 = create(:item_post, user_id: user.id)
      item_post2 = create(:item_post, user_id: user.id)
      expect(user.item_posts).to include(item_post1, item_post2)
    end

    it 'HabitPostsを含んでいること' do
      user = create(:user)
      habit_post1 = create(:habit_post, user_id: user.id)
      habit_post2 = create(:habit_post, user_id: user.id)
      expect(user.habit_posts).to include(habit_post1, habit_post2)
    end

    it 'Diariesを含んでいること' do
      user = create(:user)
      diary1 = create(:diary, user_id: user.id)
      diary2 = create(:diary, user_id: user.id)
      expect(user.diaries).to include(diary1, diary2)
    end

    it 'ItemLikesを含んでいること' do
      user = create(:user)
      item_like1 = create(:item_like, user_id: user.id)
      item_like2 = create(:item_like, user_id: user.id)
      expect(user.item_likes).to include(item_like1, item_like2)
    end

    it 'liked_item_postを正しく取得できること' do
      user = create(:user)
      item_post1 = create(:item_post, user_id: user.id)
      item_post2 = create(:item_post, user_id: user.id)
      item_like1 = create(:item_like, user_id: user.id, item_post_id: item_post1.id)
      item_like2 = create(:item_like, user_id: user.id, item_post_id: item_post2.id)
      expect(user.liked_item_posts).to include(item_post1, item_post2)
    end

    it 'HabitLikesを含んでいること' do
      user = create(:user)
      habit_like1 = create(:habit_like, user_id: user.id)
      habit_like2 = create(:habit_like, user_id: user.id)
      expect(user.habit_likes).to include(habit_like1, habit_like2)
    end

    it 'liked_habit_postを正しく取得できること' do
      user = create(:user)
      habit_post1 = create(:habit_post, user_id: user.id)
      habit_post2 = create(:habit_post, user_id: user.id)
      habit_like1 = create(:habit_like, user_id: user.id, habit_post_id: habit_post1.id)
      habit_like2 = create(:habit_like, user_id: user.id, habit_post_id: habit_post2.id)
      expect(user.liked_habit_posts).to include(habit_post1, habit_post2)
    end

    it 'ItemCommentを含んでいること' do
      user = create(:user)
      item_comment1 = create(:item_comment, user_id: user.id)
      item_comment2 = create(:item_comment, user_id: user.id)
      expect(user.item_comments).to include(item_comment1, item_comment2)
    end

    it 'HabitCommentを含んでいること' do
      user = create(:user)
      habit_comment1 = create(:habit_comment, user_id: user.id)
      habit_comment2 = create(:habit_comment, user_id: user.id)
      expect(user.habit_comments).to include(habit_comment1, habit_comment2)
    end
  end
end
