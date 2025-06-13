FactoryBot.define do
    factory :item_like do
      association :user
      association :item_post
    end
  end
    