# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
  # パスワード再設定時、メールアドレスに不備があればフラッシュメッセージを表示
  def create
    super do |resource|
      if resource.errors.any? # もしエラーがあれば
        flash[:alert] = I18n.t("devise.passwords.invalid") # カスタムメッセージを設定
      end
    end
  end

  # パスワード再設定時、パスワードに不備があればフラッシュメッセージを表示
  def update
    super do |resource|
      if resource.errors.any?
        flash[:alert] = I18n.t("devise.passwords.password_invalid") # カスタムメッセージを設定
      end
    end
  end
end
