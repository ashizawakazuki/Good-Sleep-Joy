# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  # パスワード再設定時、メールアドレスに不備があればフラッシュメッセージを表示するために作成
  def create
    super do |resource|
      if resource.errors.any? # もしエラーがあれば
        flash[:alert] = I18n.t("devise.passwords.invalid") # カスタムメッセージを設定
      end
    end
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  # PUT /resource/password
  # パスワード再設定時、パスワードに不備があればフラッシュメッセージを表示するために作成
  def update
    super do |resource|
      if resource.errors.any? # もしエラーがあれば
        flash[:alert] = I18n.t("devise.passwords.password_invalid") # カスタムメッセージを設定
      end
    end
  end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
end
