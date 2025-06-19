FactoryBot.define do
  factory :habit_post do
    title { "テストタイトル" }
    body { "テスト本文" }
    habit_post_image { "str.png" }
    association :user
    association :habit_tag
  end
end
