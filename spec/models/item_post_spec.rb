require 'rails_helper'

RSpec.describe ItemPost, type: :model do #ItemPostのモデルであることを意味
  describe 'バリデーションチェック' do
    it 'titleとbodyが有効であること' do
      item_post = build(:item_post)
      expect(item_post).to be_valid # be_validでitem_postがバリデーションが通るかを検証
    end
  end
end