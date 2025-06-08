FactoryBot.define do
  factory :item_comment do
    body { "テスト本文"}
    association :user
    association :item_post
  end
end
