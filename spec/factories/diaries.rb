FactoryBot.define do
  factory :diary do
    date { Time.current } # 現在の時刻をセット
    title { "テストタイトル"}
    association :user
  end
end
