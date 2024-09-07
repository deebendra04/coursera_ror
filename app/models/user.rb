class User < ApplicationRecord
  has_secure_password

  has_many :enrollments
  has_many :enrolled_courses, through: :enrollments, source: :course
  has_many :courses, through: :enrollments
  has_many :progresses
  has_many :reviews, dependent: :destroy
  
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true, length: { minimum: 6 }
  validates :role, presence: true, inclusion: { in: %w[student instructor admin] }
end
