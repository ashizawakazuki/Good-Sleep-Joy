FactoryBot.define do
  factory :user do
    name { "テストネーム"}
    sequence(:email) { |n| "runteq_#{n}@example.com" }
    password { "password" }
  end
end
