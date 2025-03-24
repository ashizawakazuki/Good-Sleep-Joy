class UserDecorator < Draper::Decorator
  delegate_all # Userモデルで定義したメソッド等、すべてのメソッドを引き継げるようにするためのもの

  def user_name
    "#{name}さん"
  end
end
