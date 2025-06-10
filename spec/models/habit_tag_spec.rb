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
end
