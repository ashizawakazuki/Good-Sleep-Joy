class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  # devise導入により使えるようになったメソッドで、新規登録（ログイン時）の遷移先を指定できるもの
  def after_sign_in_path_for(resource)
    root_path
  end

  protected

  def configure_permitted_parameters
    # /users/sign_up
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
