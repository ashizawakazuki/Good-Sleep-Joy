FactoryBot.define do
  factory :habit_like do
    association :user
    association :habit_post
  end
end
  