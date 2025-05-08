# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  #新規登録失敗時、フラッシュメッセージを表示するために作成
  def create
    super do |resource|
      if resource.errors.any?
        flash[:alert] = I18n.t("devise.registrations.failure") # カスタムメッセージを設定
      end
    end
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

end
