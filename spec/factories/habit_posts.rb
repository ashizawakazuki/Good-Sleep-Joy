FactoryBot.define do
  factory :habit_post do
    title { "テストタイトル"}
    body { "テスト本文"}
    association :user
    association :habit_tag
  end
end
