#新規登録失敗時、フラッシュメッセージを表示するために作成(プルリクエスト時に参考記事添付)

class RegistrationsController < Devise::RegistrationsController
    def create
      super do |resource|
        if resource.errors.any? # もしエラーがあれば
          flash[:alert] = I18n.t("devise.registrations.failure") # カスタムメッセージを設定
        end
      end
    end
  end
  