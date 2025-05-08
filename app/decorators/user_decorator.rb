class UserDecorator < Draper::Decorator
  delegate_all

  def user_name
    "#{object.name}さん"
  end
end
