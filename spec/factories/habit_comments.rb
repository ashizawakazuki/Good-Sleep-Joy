FactoryBot.define do
  factory :habit_comment do
    body { "テスト本文" }
    association :user
    association :habit_post
  end
end
