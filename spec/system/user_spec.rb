require 'rails_helper'

include LoginMacros

RSpec.describe "ユーザー登録", type: :system do
  before do
    driven_by(:rack_test)
  end

  describe "ログイン前チェック" do
    let(:user) { build(:user) }

    describe "ユーザー新規登録" do
      context "フォームの入力値が正常な場合" do
        it "ユーザーの新規作成が成功する" do
          visit new_user_registration_path
          fill_in "名前", with: user.name
          fill_in "メールアドレス", with: user.email
          fill_in "パスワード", with: user.password
          fill_in "パスワード確認", with: user.password
          click_button "新規登録"
          expect(page).to have_content "登録が完了しました!"
          expect(current_path).to eq root_path
        end
      end

      context "メールアドレスが未入力の場合" do
        it "ユーザーの新規作成が失敗する" do
          visit new_user_registration_path
          fill_in "名前", with: user.name
          fill_in "メールアドレス", with: ""
          fill_in "パスワード", with: user.password
          fill_in "パスワード確認", with: user.password
          click_button "新規登録"
          expect(page).to have_content "アカウントの登録に失敗しました。入力内容を確認してください。"
        end
      end

      context "登録済みのメールアドレスを使用の場合" do
        it "ユーザーの新規作成が失敗する" do
          existed_user = create(:user)
          visit new_user_registration_path
          fill_in "名前", with: user.name
          fill_in "メールアドレス", with: existed_user.email
          fill_in "パスワード", with: user.password
          fill_in "パスワード確認", with: user.password
          click_button "新規登録"
          expect(page).to have_content "アカウントの登録に失敗しました。入力内容を確認してください。"
        end
      end

      describe "マイページ" do
        context "ログインしていない状態の場合" do
          it "マイページへのアクセスが失敗する" do
            visit profile_path
            expect(page).to have_content "続行するにはログインするか、アカウントを作成してください。"
          end
        end
      end
    end
  end

  describe 'ログイン後チェック' do
    # ファクトリーボットのテスト用のユーザーオブジェクトを保存し、userという変数に代入
    let(:user) { create(:user) }
    # 各テストコードの実行前に、読み込んだlogin_macros.rbに定義したlogin(user)を実行（ログイン）
    before { login(user) }

    describe 'ユーザー編集' do
      context 'フォームの入力値が正常の場合' do
        it 'ユーザーの編集が成功する' do
          visit edit_profile_path
          fill_in "ユーザーネーム", with: user.name
          fill_in "メールアドレス", with: user.email
          click_button '更新する'
          expect(page).to have_content "編集が成功しました!"
          expect(current_path).to eq profile_path
        end
      end

      context 'ユーザーネームが未入力の場合' do
        it 'ユーザーの編集が失敗する' do
          visit edit_profile_path
          fill_in "ユーザーネーム", with: ""
          fill_in "メールアドレス", with: user.email
          click_button '更新する'
          expect(page).to have_content "アカウントの更新に失敗しました。入力内容を確認してください。"
          expect(page).to have_content "名前を入力してください"
          expect(current_path).to eq profile_path
        end
      end

      context 'メールアドレスが未入力の場合' do
        it 'ユーザーの編集が失敗する' do
          visit edit_profile_path
          fill_in "ユーザーネーム", with: user.name
          fill_in "メールアドレス", with: ""
          click_button '更新する'
          expect(page).to have_content "アカウントの更新に失敗しました。入力内容を確認してください。"
          expect(page).to have_content "メールアドレスを入力してください"
          expect(current_path).to eq profile_path
        end
      end

      context '登録済みのメールアドレスを使用の場合' do
        it 'ユーザーの編集が失敗する' do
          existed_user = create(:user)
          visit edit_profile_path
          fill_in "ユーザーネーム", with: user.name
          fill_in "メールアドレス", with: existed_user.email
          click_button '更新する'
          expect(page).to have_content "アカウントの更新に失敗しました。入力内容を確認してください。"
          expect(page).to have_content "メールアドレスはすでに存在します"
          expect(current_path).to eq profile_path
        end
      end
    end
  end
end
