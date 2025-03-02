class HabitComment < ApplicationRecord
  validates :body, presence: true, length: { maximum: 65_535}

  belongs_to :habit_post
  belongs_to :user
end
