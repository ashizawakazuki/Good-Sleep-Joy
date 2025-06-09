class HabitTag < ApplicationRecord
  validates :name, presence: true
  
  has_many :habit_posts,dependent: :destroy
end
