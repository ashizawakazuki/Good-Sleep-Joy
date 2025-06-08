FactoryBot.define do
  factory :user do
    name { "テストネーム"}
    sequence(:email) { |n| "runteq_#{n}@example.com" }
    password { "password" }
    password_confirmation { "password" }
  end
end
