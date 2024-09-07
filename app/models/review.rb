class Review < ApplicationRecord
  belongs_to :user
  belongs_to :course_content

  validates :user, presence: true
  validates :course_content, presence: true
  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :comment, presence: true
end
