class HabitLike < ApplicationRecord
  belongs_to :user
  belongs_to :habit_post

  validates :user_id, uniqueness: { scope: :habit_post_id }
end
