require 'rails_helper'

include LoginMacros # 事前の設定により、login_macros.rbを読み込む

RSpec.describe "ログイン処理", type: :system do

  # 軽量なrack_testドライバを使って、ブラウザを立ち上げずにテストを実行する
  before do
    driven_by(:rack_test)
  end

  # ファクトリーボットのテスト用のユーザーオブジェクトを保存し、userという変数に代入
  let(:user) {create(:user)}

  describe "ログイン前チェック" do
    context "フォームの入力値が正常な場合" do
      it "ログイン処理が成功する" do
        login(user) # 読み込んだlogin_macros.rbに定義したlogin(user)を実行
        expect(page).to have_content "ログインしました！"
        expect(current_path).to eq root_path
      end
    end

    context "フォームの入力値が異常な場合" do
      it "ログイン処理が失敗する" do
        visit new_user_session_path
        fill_in "メールアドレス", with: ""
        fill_in "パスワード", with: ""
        click_button "ログイン"
        expect(page).to have_content "メールアドレスまたはパスワードが正しくありません。"
        expect(current_path).to eq new_user_session_path
      end
    end
  end
end
