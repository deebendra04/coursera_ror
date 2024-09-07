class Enrollment < ApplicationRecord
  belongs_to :user
  belongs_to :course

  validate :user_must_be_student
  validates :course, presence: true

  private

  def user_must_be_student
    errors.add(:user, 'must be a student to enroll') unless user.role == 'student'
  end
end
