class HabitTag < ApplicationRecord
  has_many :habit_posts,dependent: :destroy
end
