require 'rails_helper'

RSpec.describe HabitTag, type: :model do
  describe 'バリデーションチェック' do
    it 'nameが有効であること' do
      habit_tag = build(:habit_tag)
      expect(habit_tag).to be_valid
    end

    it 'nameが空だと無効であること' do
      habit_tag = build(:habit_tag, name: nil)
      habit_tag.valid?
      expect(habit_tag.errors[:name]).not_to be_empty
    end
  end

  describe 'アソシエーションチェック' do
    it 'HabitPostsを含んでいること' do
      habit_tag = create(:habit_tag)
      habit_post1 = create(:habit_post, habit_tag_id: habit_tag.id)
      habit_post2 = create(:habit_post, habit_tag_id: habit_tag.id)
      expect(habit_tag.habit_posts).to include(habit_post1, habit_post2)
    end
  end
end
