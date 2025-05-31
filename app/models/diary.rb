class Diary < ApplicationRecord
  validates :date, presence: true
  validates :title, presence: true, length: { maximum: 50 }
  belongs_to :user
end
