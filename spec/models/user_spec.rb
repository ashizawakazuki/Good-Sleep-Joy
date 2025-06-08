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
end
