require 'rails_helper'

RSpec.describe HabitComment, type: :model do
  describe 'バリデーションチェック' do
    it 'bodyが有効であること' do
      habit_comment = build(:habit_comment) 
      expect(habit_comment).to be_valid
    end

    it 'bodyが65,536以上だと無効であること' do
      habit_comment = build(:habit_comment, body: "a" * 65_536)
      habit_comment.valid?
      expect(habit_comment.errors[:body]).not_to be_empty
    end

    it 'bodyが空だと無効であること' do
      habit_comment = build(:habit_comment, body: nil )
      habit_comment.valid?
      expect(habit_comment.errors[:body]).not_to be_empty
    end
  end
end
