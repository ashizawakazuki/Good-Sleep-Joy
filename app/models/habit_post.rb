class HabitPost < ApplicationRecord
  validates :title, presence: true, length: { maximum: 50 }
  validates :body, presence: true, length: { maximum: 1000 }
  validates :habit_post_image, presence: true

  belongs_to :user
  belongs_to :habit_tag
  has_many :habit_likes, dependent: :destroy
  has_many :habit_comments, dependent: :destroy

  def self.ransackable_attributes(auth_object = nil)
    ["title","body","habit_tag_id"]
  end
  

  def self.ransackable_associations(auth_object = nil)
    []
  end

end
