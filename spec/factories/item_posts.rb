FactoryBot.define do
  factory :item_post do
    title { "テストタイトル"}
    body { "テスト本文"}
    association :user
    association :item_tag
  end
end