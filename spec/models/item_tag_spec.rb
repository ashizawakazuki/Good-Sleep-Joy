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

  describe 'アソシエーションチェック' do
    it 'ItemPostsを含んでいること' do
      item_tag = create(:item_tag)
      item_post1 = create(:item_post, item_tag_id: item_tag.id)
      item_post2 = create(:item_post, item_tag_id: item_tag.id)
      expect(item_tag.item_posts).to include(item_post1,item_post2)
    end
  end
end
