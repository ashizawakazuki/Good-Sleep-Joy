require 'rails_helper'

RSpec.describe ItemTag, type: :model do
  describe 'バリデーションチェック' do
    it 'nameが有効であること' do
      item_tag = build(:item_tag)
      expect(item_tag).to be_valid
    end

    it 'nameが空だと無効であること' do
      item_tag = build(:item_tag, name: nil)
      item_tag.valid?
      expect(item_tag.errors[:name]).not_to be_empty
    end
  end
end
